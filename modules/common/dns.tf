resource "google_dns_managed_zone" "google_apis" {
  name        = "${var.google_apis_zone}"
  project     = "${var.project}"
  dns_name    = "googleapis.com."
  description = "private zone for Google API's"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "https://www.googleapis.com/compute/v1/projects/${var.project}/global/networks/${module.vpc.network_name}"
    }
  }

  depends_on = ["module.vpc"]
}

resource "google_dns_managed_zone" "gcr_io" {
  name        = "${var.gcr_io_zone}"
  project     = "${var.project}"
  dns_name    = "gcr.io."
  description = "private zone for GCR.io"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "https://www.googleapis.com/compute/v1/projects/${var.project}/global/networks/${module.vpc.network_name}"
    }
  }

  depends_on = ["module.vpc"]
}

resource "google_dns_record_set" "restricted_google_apis_A_record" {
  name    = "restricted.googleapis.com."
  project = "${var.project}"
  type    = "A"
  ttl     = 300

  managed_zone = "${google_dns_managed_zone.google_apis.name}"

  rrdatas = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
}

resource "google_dns_record_set" "google_api_CNAME" {
  name    = "*.googleapis.com."
  project = "${var.project}"
  type    = "CNAME"
  ttl     = 300

  managed_zone = "${google_dns_managed_zone.google_apis.name}"

  rrdatas = ["restricted.googleapis.com."]
}

resource "google_dns_record_set" "restricted_gcr_io_A_record" {
  name    = "gcr.io."
  project = "${var.project}"
  type    = "A"
  ttl     = 300

  managed_zone = "${google_dns_managed_zone.gcr_io.name}"

  rrdatas = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
}

resource "google_dns_record_set" "gcr_io_CNAME" {
  name    = "*.gcr.io."
  project = "${var.project}"
  type    = "CNAME"
  ttl     = 300

  managed_zone = "${google_dns_managed_zone.gcr_io.name}"

  rrdatas = ["gcr.io."]
}
