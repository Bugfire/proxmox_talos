# Terraform for Proxmox/talos

- ref. https://olav.ninja/talos-cluster-on-proxmox-with-terraform
- ref. https://registry.terraform.io/providers/siderolabs/talos/0.8.1/docs
- ref. https://registry.terraform.io/providers/bpg/proxmox/latest/docs

## setup

Lets see .env.sample for environment variables
and settings.tf

### image_url

ref. https://factory.talos.dev/

- 1 - Cloud Server
- 2 - 1.10.4
- 3 - Nocloud
- 4 - amd64 (secureboot off)
- 5 - siderolabs/qemu-guest-agent (10.0.2)
- 6 - console=ttyS0,115200

```
Your image schematic ID is: b027a2d9dddfa5c0752c249cf3194bb5c62294dc7cba591f3bec8119ab578aea
```

https://factory.talos.dev/image/b027a2d9dddfa5c0752c249cf3194bb5c62294dc7cba591f3bec8119ab578aea/v1.10.4/nocloud-amd64.raw.xz

replace xz ext to gz

https://factory.talos.dev/image/b027a2d9dddfa5c0752c249cf3194bb5c62294dc7cba591f3bec8119ab578aea/v1.10.4/nocloud-amd64.raw.gz
