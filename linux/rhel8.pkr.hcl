packer {

  required_version = ">= 1.10.0"

  required_plugins {
    vmware = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "rhel89" {

  # VM Hardware Configuration
  vm_name              = "rhel89"
  guest_os_type        = "rhel8-64"
  version              = "21"
  cpus                 = 2
  cores                = 1
  memory               = 4096
  vmdk_name            = "rhel89"
  disk_size            = 40960
  disk_adapter_type    = "nvme"
  disk_type_id         = "0"
  network              = "NAT"
  network_adapter_type = "vmxnet3"

  # Removable Media Configuration
  iso_url      = "G:\\Red Hat\\rhel-8.9-x86_64-dvd.iso"
  iso_checksum = "sha256:C4FD0632CE15A7D56E1D174176456943BD48306F9D35BCECBCB0A1DC49088E23"

  # Build Settings
  format               = "ova"
  headless             = false
  boot_command         = ["<tab><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait15s><esc>"]
  boot_wait            = "30s"
  http_directory       = "http"
  communicator         = "ssh"
  ssh_port             = 22
  ssh_username         = "root"
  ssh_password         = "D0wnT0wn"
  ssh_timeout          = "30m"
  shutdown_command     = "echo 'packer'|sudo systemctl poweroff"
  shutdown_timeout     = "10m"
  output_directory     = "D:\\Templates\\rhel89"
  cleanup_remote_cache = true
}

build {
  name = "Red Hat Enterprise Linix 8.9"
  sources = [
    "source.vmware-iso.rhel89"
  ]
}