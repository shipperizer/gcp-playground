terraform {
  required_version = "~> 0.12"

  backend "gcs" {
    prefix = "terraform/state"
  }
}
