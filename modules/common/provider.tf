provider "google" {
  version = "~> 2.10"
  project = "${var.project}"
  region  = "${var.region}"
}

provider "google-beta" {
  version = "~> 2.10"
  project = "${var.project}"
  region  = "${var.region}"
}

provider "random" {
  version = "~> 2.1"
}
