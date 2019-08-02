resource "google_compute_firewall" "deny_egress" {
  name    = "deny-all-egress-${var.project}-${var.workspace}"
  project = "${var.project}"
  network = "${module.vpc.network_name}"

  deny {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
  priority           = "1100"
  target_tags        = ["private"]

  depends_on = ["module.vpc"]
}

resource "google_compute_firewall" "allow_healthcheck_ingress" {
  name    = "allow-hc-ingress-${var.project}-${var.workspace}"
  project = "${var.project}"
  network = "${module.vpc.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction     = "INGRESS"
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags        = ["private"]

  depends_on = ["module.vpc"]
}


resource "google_compute_firewall" "allow_bastion_ssh_ingress" {
  name    = "allow-bastion-ssh-ingress-${var.project}-${var.workspace}"
  project = "${var.project}"
  network = "${module.vpc.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction     = "INGRESS"
  source_ranges = ["${google_compute_address.bastion.address}/32"]
  target_tags   = ["private"]

  depends_on = ["module.vpc"]
}

resource "google_compute_firewall" "allow_ssh_internal_ingress" {
  name    = "allow-ssh-internal-ingress-${var.project}-${var.workspace}"
  project = "${var.project}"
  network = "${module.vpc.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction = "INGRESS"

  source_ranges = "${local.internal_cidrs.*.cidr_block}"

  depends_on = ["module.vpc"]
}

resource "google_compute_firewall" "allow_healthcheck_egress" {
  name    = "allow-hc-egress-${var.project}-${var.workspace}"
  project = "${var.project}"
  network = "${module.vpc.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction          = "EGRESS"
  destination_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  depends_on         = ["module.vpc"]
}

resource "google_compute_firewall" "allow_google_apis" {
  name    = "allow-gapi-egress-${var.project}-${var.workspace}"
  project = "${var.project}"
  network = "${module.vpc.network_name}"

  allow {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = ["199.36.153.4/30"]

  depends_on         = ["module.vpc"]
}

resource "google_compute_firewall" "allow_master_node_egress" {
  name    = "allow-gke-master-egress-${var.project}-${var.workspace}"
  project = "${var.project}"
  network = "${module.vpc.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["443", "10250"]
  }

  direction          = "EGRESS"
  destination_ranges = ["172.16.0.0/28"]

  depends_on         = ["module.vpc"]
}
