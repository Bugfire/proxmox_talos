variable "params" {
  type = object({
    name    = string
    ip_addr = string
    node    = string
  })
}

variable "common" {
  type = object({
    gateway = string
    ip_mask = number
    cores   = number
    mem_mb  = number
    disk_gb = number
    images  = map(any)
  })
}

variable "client_configuration" {
}

variable "machine_configuration" {
}

resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.params.name
  description = "Managed by Terraform"
  tags        = ["terraform"]
  node_name   = var.params.node
  on_boot     = true

  cpu {
    cores        = var.common.cores
    type         = "host"
    architecture = "x86_64"
  }

  memory {
    dedicated = var.common.mem_mb
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = var.common.images[var.params.node].id
    file_format  = "raw"
    interface    = "virtio0"
    size         = var.common.disk_gb
  }

  operating_system {
    # Linux Kernel 2.6 - 5.X.
    type = "l26"
  }

  initialization {
    datastore_id = "local-lvm"
    ip_config {
      ipv4 {
        address = "${var.params.ip_addr}/${var.common.ip_mask}"
        gateway = var.common.gateway
      }
      ipv6 {
        address = "dhcp"
      }
    }
  }
}

resource "talos_machine_configuration_apply" "config_apply" {
  depends_on = [proxmox_virtual_environment_vm.vm]

  client_configuration        = var.client_configuration
  machine_configuration_input = var.machine_configuration
  node                        = var.params.ip_addr
}
