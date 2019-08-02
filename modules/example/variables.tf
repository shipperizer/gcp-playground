variable "project" {
  default = "shp-x-10"
}

variable "region" {
  default = "europe-west1"
}

variable "workspace" {
  default = "shipperizer"
}

variable "gke_cluster" {
  default = "shipperizer"
}

variable "subnet_private_cidr" {
  default = "100.27.0.0/22"
}

variable "subnet_boundary_cidr" {
  default = "100.27.10.0/24"
}

variable "subnet_private_pod_cidr" {
  default = "100.27.4.0/22"
}

variable "subnet_private_service_cidr" {
  default = "100.27.8.0/23"
}

variable "nat_router" {
  default = "shipperizer"
}
