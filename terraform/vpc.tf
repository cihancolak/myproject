provider "google" {
  project = "jumpbox-427107"
  region  = "europe-west4-b"
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
  project                 = " jumpbox-427107"

  // Etiketler
  labels = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "google_compute_subnetwork" "public_subnet" {
  count             = 3
  name              = "public-subnet-${count.index + 1}"
  network           = google_compute_network.vpc_network.id
  ip_cidr_range     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"][count.index]
  region            = "europe-west4-b"  # Bölgenizi buraya girin
  private_ip_google_access = false  # GCP'de özel erişimi kapalı bırakabilirsiniz

  // Etiketler
  labels = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "google_compute_subnetwork" "private_subnet" {
  count             = 3
  name              = "private-subnet-${count.index + 1}"
  network           = google_compute_network.vpc_network.id
  ip_cidr_range     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"][count.index]
  region            = "europe-west4-b"  # Bölgenizi buraya girin
  private_ip_google_access = true  # Özel IP erişimini açık bırakabilirsiniz

  // Etiketler
  labels = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "google_compute_router" "router" {
  name    = "my-router"
  network = google_compute_network.vpc_network.id
  region  = "europe-west4-b"  # Bölgenizi buraya girin

  // Etiketler
  labels = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "google_compute_router_nat" "router_nat" {
  name   = "my-nat"
  router = google_compute_router.router.id
  region = "europe-west4-b"  # Bölgenizi buraya girin

  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  
  // Etiketler
  labels = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "google_compute_vpn_gateway" "vpn" {
  name    = "my-vpn-gateway"
  network = google_compute_network.vpc_network.id
  region  = "europe-west4-b"  # Bölgenizi buraya girin

  // Etiketler
  labels = {
    Terraform = "true"
    Environment = "dev"
  }
}

