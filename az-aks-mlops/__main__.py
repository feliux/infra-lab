import base64
import pulumi

import pulumi_azuread as azuread

from pulumi import ResourceOptions
from pulumi_azure_native import resources, storage, containerservice, network, authorization
from pulumi_kubernetes import Provider
from pulumi_kubernetes.apps.v1 import Deployment
from pulumi_kubernetes.core.v1 import Service, Namespace


RG_NAME = "aks-testing"
STORAGE_NAME = "aksblobstorage"

# Pulumi config
config = pulumi.Config("aks-mlops")
prefix = config.require("prefix")
password = config.require("password")
ssh_public_key = config.require("sshkey")
location = config.get("location") or "east us"
subscription_id = authorization.get_client_config().subscription_id

# Vnet config
vnet_address_prefixes = ["10.0.0.0/16"]
subnet_address_prefix = "10.0.0.0/24"

# AKS config
kubernetes_version = "1.22.6"
vm_size = "Standard_B2ms",
vm_count = "2"
max_pods = 110
admin_user = "azureuser"
network_profile={
    "network_plugin": "azure",
    "service_cidr": "10.10.0.0/16",
    "dns_service_ip": "10.10.0.10",
    "docker_bridge_cidr": "172.17.0.1/16"
}

# Create Azure AD Application for AKS
app = azuread.Application(
    f"{prefix}-aks",
    display_name=f"{prefix}-aks"
)

# Create service principal for the application so AKS can act on behalf of the application
sp = azuread.ServicePrincipal(
    f"{prefix}-aks-sp",
    application_id=app.application_id
)

# Create the service principal password
sppwd = azuread.ServicePrincipalPassword(
    f"{prefix}-aks-sp-pwd",
    service_principal_id=sp.id,
    end_date="2099-01-01T00:00:00Z"
)

# Create an Azure Resource Group
resource_group = resources.ResourceGroup(
    RG_NAME,
    location=location
    )

# Create Storage Account
account = storage.StorageAccount(
    STORAGE_NAME,
    resource_group_name=resource_group.name,
    sku=storage.SkuArgs(
        name=storage.SkuName.STANDARD_LRS,
    ),
    kind=storage.Kind.STORAGE_V2)

# Create VNET
vnet = network.VirtualNetwork(
    f"{prefix}-vnet",
    location=resource_group.location,
    resource_group_name=resource_group.name,
    address_space={
        "address_prefixes": vnet_address_prefixes,
    }
)

subnet = network.Subnet(
    f"{prefix}-subnet",
    resource_group_name=resource_group.name,
    address_prefix=subnet_address_prefix,
    virtual_network_name=vnet.name
)

subnet_assignment = authorization.RoleAssignment(
    f"{prefix}-subnet-permissions",
    principal_id=sp.id,
    principal_type=authorization.PrincipalType.SERVICE_PRINCIPAL,
    role_definition_id=f"/subscriptions/{subscription_id}/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7", # ID for Network Contributor role
    scope=subnet.id
)

# AKS
aks = containerservice.ManagedCluster(
    f"{prefix}-aks",
    location=resource_group.location,
    resource_group_name=resource_group.name,
    kubernetes_version=kubernetes_version,
    dns_prefix="dns",
    agent_pool_profiles=[{
        "name": "type1",
        "mode": "System",
        "count": vm_count,
        "vm_size": vm_size,
        "os_type": containerservice.OSType.LINUX,
        "max_pods": max_pods,
        "vnet_subnet_id": subnet.id
    }],
    linux_profile={
        "admin_username": admin_user,
        "ssh": {
            "public_keys": [{
                "key_data": ssh_public_key
            }]
        }
    },
    service_principal_profile={
        "client_id": app.application_id,
        "secret": sppwd.value
    },
    enable_rbac=True,
    network_profile=network_profile,
    opts=ResourceOptions(depends_on=[subnet_assignment])
)

kube_creds = pulumi.Output.all(resource_group.name, aks.name).apply(
    lambda args:
    containerservice.list_managed_cluster_user_credentials(
        resource_group_name=args[0],
        resource_name=args[1]))

kube_config = kube_creds.kubeconfigs[0].value.apply(
    lambda enc: base64.b64decode(enc).decode())


custom_provider = Provider(
    "inflation_provider", kubeconfig=kube_config
)

# Export Kubeconfig
pulumi.export("kubeconfig", kube_config)

# Export the primary key of the Storage Account
primary_key = pulumi.Output.all(
    resource_group.name,
    account.name
    ).apply(
        lambda args: storage.list_storage_account_keys(
            resource_group_name=args[0],
            account_name=args[1]
    )).apply(lambda accountKeys: accountKeys.keys[0].value)

pulumi.export("primary_storage_key", primary_key)
