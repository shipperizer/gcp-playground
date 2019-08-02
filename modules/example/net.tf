module "net" {
  source = "../common"

  project                     = "${var.project}"
  region                      = "${var.region}"
  workspace                   = "${var.workspace}"
  subnet_private_cidr         = "${var.subnet_private_cidr}"
  subnet_boundary_cidr        = "${var.subnet_boundary_cidr}"
  subnet_private_pod_cidr     = "${var.subnet_private_pod_cidr}"
  subnet_private_service_cidr = "${var.subnet_private_service_cidr}"
  nat_router                  = "${var.nat_router}"
  gke_cluster                 = "${var.gke_cluster}"
}
