locals {
  talos_cp_first = local.talos_cp_list[0]

  talos_cp_other_map = {
    for item in slice(local.talos_cp_list, 1, length(local.talos_cp_list)) : item.name => item
  }

  talos_wk_map = {
    for item in local.talos_wk_list : item.name => item
  }

  talos_endpoint_ip_addr = local.talos_cp_first.ip_addr
  talos_endpoint         = "https://${local.talos_endpoint_ip_addr}:6443"

  talos_cp_ip_addr_list = [for item in local.talos_cp_list : item.ip_addr]
  talos_wk_ip_addr_list = [for item in local.talos_wk_list : item.ip_addr]
}
