resource "talos_machine_secrets" "machine_secrets" {}

data "talos_client_configuration" "talosconfig" {
  cluster_name         = local.talos_name
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoints            = [local.talos_endpoint_ip_addr]
  nodes                = concat(local.talos_cp_ip_addr_list, local.talos_wk_ip_addr_list)
}

data "talos_machine_configuration" "machineconfig_cp" {
  cluster_name     = local.talos_name
  cluster_endpoint = local.talos_endpoint
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

data "talos_machine_configuration" "machineconfig_wk" {
  cluster_name     = local.talos_name
  cluster_endpoint = local.talos_endpoint
  machine_type     = "worker"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "talos_cluster_kubeconfig" "kubeconfig" {
  depends_on           = [talos_machine_bootstrap.bootstrap, data.talos_cluster_health.health_talos]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = local.talos_endpoint_ip_addr
}

output "talosconfig" {
  value     = data.talos_client_configuration.talosconfig.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  sensitive = true
}
