# Set by env TF_VAR_proxmox_endpoint
variable "proxmox_endpoint" {
  type = string
}

locals {
  image_url       = "https://factory.talos.dev/image/b027a2d9dddfa5c0752c249cf3194bb5c62294dc7cba591f3bec8119ab578aea/v1.10.4/nocloud-amd64.raw.gz"
  image_file_name = "talos-1.10.4-nocloud-amd64.img"

  proxmox_nodes = [
    "dynadesk1",
    "deskmeet1"
  ]

  talos_name = "talos-k8s"

  talos_common = {
    gateway = "192.168.14.1"
    ip_mask = 24
    cores   = 4
    mem_mb  = 4096
    disk_gb = 128
    images  = proxmox_virtual_environment_download_file.image_by_node
  }

  talos_cp_list = [
    {
      name    = "talos-cp-01"
      ip_addr = "192.168.14.70"
      node    = "deskmeet1"
    },
    {
      name    = "talos-cp-02"
      ip_addr = "192.168.14.71"
      node    = "dynadesk1"
    },
  ]

  talos_wk_list = [
    {
      name    = "talos-wk-01"
      ip_addr = "192.168.14.72"
      node    = "deskmeet1"
    },
    {
      name    = "talos-wk-02"
      ip_addr = "192.168.14.73"
      node    = "dynadesk1"
    },
    {
      name    = "talos-wk-03"
      ip_addr = "192.168.14.74"
      node    = "dynadesk1"
    },
  ]
}
