variable "project" {}
variable "region" {}
variable "workspace" {}
variable "subnet_private_cidr" {}
variable "subnet_boundary_cidr" {}
variable "subnet_private_pod_cidr" {}
variable "subnet_private_service_cidr" {}
variable "nat_router" {}

variable "nat_allocate_option" {
  default = "AUTO_ONLY"
}

variable "min_ports_per_vm" {
  # This is the max number of connections an instance (and all of its pods)
  # Will be able to make to a single host:port combination
  # Default is 64, 512 should be plenty and allows ~120 instances to share a single nat IP
  # https://cloud.google.com/nat/docs/overview#number_of_nat_ports_and_connections"
  default = 512

  description = "Connections per instance"
}

variable "google_apis_route" {
  description = "Route to restricted Google APIs"
  default     = "google-apis"
}

variable "google_apis_zone" {
  description = "Name for google apis zone"
  default     = "google-apis"
}

variable "gcr_io_zone" {
  description = "Name for GCR.io zone"
  default     = "gcr-io"
}

variable "gke_cluster" {
  description = "Name for the GKE cluster"
  default     = "gke-test"
}

variable "gke_zones" {
  description = "Zones the GKE cluster is using"
  type        = "list"
  default     = ["europe-west1-b", "europe-west1-c"]
}

variable "gke_master_node_range" {
  description = "GKE cluster master node range"
  default     = "172.16.0.0/28"
}

variable "gke_machine_type" {
  description = "GKE cluster machine type for node pools"
  default     = "f1-micro"
}
