module "talos_cp_first_node" {
  source = "./node"

  params = local.talos_cp_first
  common = local.talos_common

  client_configuration  = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration = data.talos_machine_configuration.machineconfig_cp.machine_configuration
}

resource "talos_machine_bootstrap" "bootstrap" {
  depends_on           = [module.talos_cp_first_node]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = local.talos_endpoint_ip_addr
}

module "talos_cp_rest_nodes" {
  for_each = local.talos_cp_other_map

  depends_on = [talos_machine_bootstrap.bootstrap]

  source = "./node"

  params = each.value
  common = local.talos_common

  client_configuration  = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration = data.talos_machine_configuration.machineconfig_cp.machine_configuration
}

module "talos_wk_nodes" {
  for_each = local.talos_wk_map

  depends_on = [talos_machine_bootstrap.bootstrap]

  source = "./node"

  params = each.value
  common = local.talos_common

  client_configuration  = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration = data.talos_machine_configuration.machineconfig_wk.machine_configuration
}
