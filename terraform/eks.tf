provider "google" {
  project = "jumpbox-427107"
  region  = "europe-west4-b"  # Bölgenizi buraya girin
}

resource "google_container_cluster" "gke_cluster" {
  name               = "my-cluster"
  location           = "europe-west4-b"  # Bölgenizi buraya girin
  initial_node_count = 1
  min_master_version = "1.27"

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

 
  ip_allocation_policy {
    use_ip_aliases = true
  }

  
  labels = {
    Environment = "dev"
    Terraform   = "true"
  }
}

resource "google_container_node_pool" "default_pool" {
  name       = "default-pool"
  location   = "europe-west4-b"  # Bölgenizi buraya girin
  cluster    = google_container_cluster.gke_cluster.id
  node_count = 3

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }
}

output "cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "cluster_endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate
}

