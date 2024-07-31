provider "google" {
  project = "jumpbox-427107"
  region  = "europe-west4-b"  # Bölgenizi buraya girin
}

resource "google_artifact_registry_repository" "my_repo" {
  name     = "my-repo"
  format   = "DOCKER"
  location = "europe-west4-b"  # Bölgenizi buraya girin

  // Etiketler
  labels = {
    Terraform = "true"
    Environment = "dev"
  }
}

output "repository_url" {
  value = "gcr.io/${google_artifact_registry_repository.my_repo.project}/${google_artifact_registry_repository.my_repo.name}"
}

