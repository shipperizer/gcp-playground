module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 4.0"

  project_id                 = "${var.project}"
  name                       = "${var.gke_cluster}"
  regional                   = false
  region                     = "${var.region}"
  zones                      = "${var.gke_zones}"
  network                    = "${module.vpc.network_name}"
  subnetwork                 = "${element(module.vpc.subnets_names, 0)}"
  ip_range_pods              = "private-pod-${var.project}-${var.workspace}"
  ip_range_services          = "private-service-${var.project}-${var.workspace}"
  service_account            = "create"
  network_policy             = true
  enable_private_endpoint    = false
  enable_private_nodes       = true
  kubernetes_dashboard       = true
  remove_default_node_pool   = true
  horizontal_pod_autoscaling = true

  master_ipv4_cidr_block     = "${var.gke_master_node_range}"
  master_authorized_networks_config = [
    {
      cidr_blocks = "${local.internal_cidrs}"
    },
  ]

  stub_domains = {
    "shipperizer.io" = ["100.27.1.50"]
  }

  node_pools = [
    {
      name               = "blue"
      machine_type       = "${var.gke_machine_type}"
      min_count          = 1
      max_count          = 2
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 1
    },
    {
      name               = "green"
      machine_type       = "${var.gke_machine_type}"
      min_count          = 0
      max_count          = 1
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 0
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    blue = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    green = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    green = {}

    blue = {
      default = "true"
    }

  }

  node_pools_metadata = {
    all = {}

    blue = {
      node-pool-metadata-custom-value = "blue-node-pool"
    }

    green = {
      node-pool-metadata-custom-value = "green-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    blue = [
      {
        key    = "blue"
        value  = "true"
        effect = "PREFER_NO_SCHEDULE"
      },
    ]

    green = [
      {
        key    = "green"
        value  = "true"
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = ["private"]
    blue = []
    green = []
  }
}

data "google_client_config" "default" {}
