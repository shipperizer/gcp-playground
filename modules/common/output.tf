output "network_name" {
  value       = "${module.vpc.network_name}"
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = "${module.vpc.network_self_link}"
  description = "The URI of the VPC being created"
}

output "svpc_host_project_id" {
  value       = "${module.vpc.svpc_host_project_id}"
  description = "Shared VPC host project id."
}

output "subnets_names" {
  value       = "${module.vpc.subnets_names}"
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = "${module.vpc.subnets_ips}"
  description = "The IPs and CIDRs of the subnets being created"
}

output "subnets_self_links" {
  value       = "${module.vpc.subnets_self_links}"
  description = "The self-links of subnets being created"
}

output "subnets_regions" {
  value       = "${module.vpc.subnets_regions}"
  description = "The region where the subnets will be created"
}

output "subnets_private_access" {
  value       = "${module.vpc.subnets_private_access}"
  description = "Whether the subnets will have access to Google API's without a public IP"
}

output "subnets_flow_logs" {
  value       = "${module.vpc.subnets_flow_logs}"
  description = "Whether the subnets will have VPC flow logs enabled"
}

output "subnets_secondary_ranges" {
  value       = "${module.vpc.subnets_secondary_ranges}"
  description = "The secondary ranges associated with these subnets"
}

output "routes" {
  value       = "${module.vpc.routes}"
  description = "The routes associated with this VPC"
}

output "gke_name" {
  description = "Cluster name"
  value       = "${module.gke.name}"
}

output "gke_type" {
  description = "Cluster type (regional / zonal)"
  value       = "${module.gke.type}"
}

output "gke_location" {
  description = "Cluster location (region if regional cluster, zone if zonal cluster)"
  value       = "${module.gke.location}"
}

output "gke_region" {
  description = "Cluster region"
  value       = "${module.gke.region}"
}

output "gke_zones" {
  description = "List of zones in which the cluster resides"
  value       = "${module.gke.zones}"
}

output "gke_endpoint" {
  sensitive   = true
  description = "Cluster endpoint"
  value       = "${module.gke.endpoint}"
}

output "gke_min_master_version" {
  description = "Minimum master kubernetes version"
  value       = "${module.gke.min_master_version}"
}

output "gke_logging_service" {
  description = "Logging service used"
  value       = "${module.gke.logging_service}"
}

output "gke_monitoring_service" {
  description = "Monitoring service used"
  value       = "${module.gke.monitoring_service}"
}

output "gke_master_authorized_networks_config" {
  description = "Networks from which access to master is permitted"
  value       = "${module.gke.master_authorized_networks_config}"
}

output "gke_master_version" {
  description = "Current master kubernetes version"
  value       = "${module.gke.master_version}"
}

output "gke_ca_certificate" {
  sensitive   = true
  description = "Cluster ca certificate (base64 encoded)"
  value       = "${module.gke.ca_certificate}"
}

output "gke_network_policy_enabled" {
  description = "Whether network policy enabled"
  value       = "${module.gke.network_policy_enabled}"
}

output "gke_http_load_balancing_enabled" {
  description = "Whether http load balancing enabled"
  value       = "${module.gke.http_load_balancing_enabled}"
}

output "gke_horizontal_pod_autoscaling_enabled" {
  description = "Whether horizontal pod autoscaling enabled"
  value       = "${module.gke.horizontal_pod_autoscaling_enabled}"
}

output "gke_kubernetes_dashboard_enabled" {
  description = "Whether kubernetes dashboard enabled"
  value       = "${module.gke.kubernetes_dashboard_enabled}"
}

output "gke_node_pools_names" {
  description = "List of node pools names"
  value       = "${module.gke.node_pools_names}"
}

output "gke_node_pools_versions" {
  description = "List of node pools versions"
  value       = "${module.gke.node_pools_versions}"
}

output "gke_service_account" {
  description = "The service account to default running nodes as if not overridden in `node_pools`."
  value       = "${module.gke.service_account}"
}
