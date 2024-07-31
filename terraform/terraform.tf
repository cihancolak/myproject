terraform {
  cloud {
    organization = "devops-project-org"

    workspaces {
      name = "devops-project-workspace"
    }
  }
}

provider "google" {
  project = " jumpbox-427107"
  region  = "europe-west4-b" 
}

