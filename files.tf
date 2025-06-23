resource "proxmox_virtual_environment_download_file" "image_by_node" {
  for_each = toset(local.proxmox_nodes)

  content_type = "iso"
  datastore_id = "local"
  node_name    = each.value

  url                     = local.image_url
  file_name               = local.image_file_name
  decompression_algorithm = "gz"
  overwrite               = false
}
