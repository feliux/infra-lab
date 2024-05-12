/*
resource "databricks_user" "me" {
  user_name    = var.me_email
}

resource "databricks_group_member" "me_admin" {
  group_id = data.databricks_group.admins.id
  member_id = databricks_user.me.id
}
*/

resource "databricks_user" "custom_user" {
  user_name                  = "example@test.com"
  display_name               = "Example user"
  allow_cluster_create       = false
  allow_instance_pool_create = false
}

resource "databricks_group" "developers" {
  display_name               = "developers"
  allow_cluster_create       = false
  allow_instance_pool_create = false
  workspace_access           = true
  databricks_sql_access      = false
}

resource "databricks_group_member" "current_developer" {
  group_id  = databricks_group.developers.id
  member_id = data.databricks_current_user.current_user.id
}

resource "databricks_group_member" "custom_developer" {
  group_id  = databricks_group.developers.id
  member_id = databricks_user.custom_user.id
}
