provider "google" {
  version = "~> 2.13"
}

provider "google-beta" {
  version = "~> 2.13"
}

provider "random" {
  version = "~> 2.2"
}

resource "random_id" "name" {
  byte_length = 2
}
