resource "google_compute_instance" "bastion" {
  name         = "bastion-${var.project}-${var.workspace}"
  machine_type = "f1-micro"
  zone         = "${var.region}-b"

  tags = ["bastion", "${var.project}", "public"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${element(module.vpc.subnets_self_links, 1)}"

    access_config {
      nat_ip = "${google_compute_address.bastion.address}"
    }
  }


  depends_on = ["module.vpc"]
}

resource "google_compute_address" "bastion" {
  project = "${var.project}"
  region  = "${var.region}"
  name    = "bastion-${var.project}-${var.workspace}"
}
