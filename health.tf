data "talos_cluster_health" "health_talos" {
  depends_on = [
    module.talos_cp_rest_nodes,
    module.talos_wk_nodes,
  ]

  client_configuration   = data.talos_client_configuration.talosconfig.client_configuration
  skip_kubernetes_checks = true
  control_plane_nodes    = local.talos_cp_ip_addr_list
  worker_nodes           = local.talos_wk_ip_addr_list
  endpoints              = data.talos_client_configuration.talosconfig.endpoints

  timeouts = { read = "180s" }
}

data "talos_cluster_health" "health_k8s" {
  depends_on = [
    module.talos_cp_rest_nodes,
    module.talos_wk_nodes,
    data.talos_cluster_health.health_talos,
  ]

  client_configuration   = data.talos_client_configuration.talosconfig.client_configuration
  skip_kubernetes_checks = false
  control_plane_nodes    = local.talos_cp_ip_addr_list
  worker_nodes           = local.talos_wk_ip_addr_list
  endpoints              = data.talos_client_configuration.talosconfig.endpoints

  timeouts = { read = "180s" }
}
