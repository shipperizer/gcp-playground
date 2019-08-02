module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 1.1"

  project_id                             = "${var.project}"
  network_name                           = "${var.workspace}"
  routing_mode                           = "REGIONAL"
  delete_default_internet_gateway_routes = "true"
  description                            = "VPC network for ${var.workspace}"
  subnets = [
    {
      subnet_name           = "private-${var.project}-${var.workspace}"
      subnet_ip             = "${var.subnet_private_cidr}"
      subnet_region         = "${var.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "boundary-${var.project}-${var.workspace}"
      subnet_ip             = "${var.subnet_boundary_cidr}"
      subnet_region         = "${var.region}"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]

  secondary_ranges = {
    "private-${var.project}-${var.workspace}" = [
      {
        range_name    = "private-pod-${var.project}-${var.workspace}"
        ip_cidr_range = "${var.subnet_private_pod_cidr}"
      },
      {
        range_name    = "private-service-${var.project}-${var.workspace}"
        ip_cidr_range = "${var.subnet_private_service_cidr}"
      },
    ]

    "boundary-${var.project}-${var.workspace}" = []
  }

  routes = [
    {
      name              = "${var.google_apis_route}"
      destination_range = "199.36.153.4/30"
      next_hop_internet = "true"
      description       = "Allow egress to google-apis"
      tags = "private"
    },
    {
      name              = "allow-all-internet-traffic-egress"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
      description       = "Allow all egress on public subnet"
      tags = "public"
    },
  ]
}

resource "google_compute_address" "nat" {
  project = "${var.project}"
  region  = "${var.region}"
  name    = "nat-ip-${var.project}-${var.workspace}"
}

resource "google_compute_router" "router" {
  name    = "router-${var.project}-${var.workspace}"
  network = "${module.vpc.network_name}"

  depends_on = ["module.vpc"]
}

resource "google_compute_router_nat" "nat" {
  provider = "google-beta"
  name     = "nat-router-${var.project}-${var.workspace}"
  router   = "${google_compute_router.router.name}"

  # AUTO_ONLY is the only one supported for the time being
  nat_ip_allocate_option = "AUTO_ONLY"

  min_ports_per_vm = "${var.min_ports_per_vm}"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = "${element(module.vpc.subnets_self_links, 0)}"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
