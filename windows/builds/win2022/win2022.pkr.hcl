packer {

  required_version = ">= 1.10.2"

  required_plugins {
    vmware = {
      version = ">= 1.0.11"
      source  = "github.com/hashicorp/vmware"
    }
  }

  required_plugins {
    windows-update = {
      version = ">= 0.15.0"
      source  = "github.com/rgl/windows-update"
    }
  }
}

source "vmware-iso" "win2022dc" {

  # VM Hardware Configuration

  vm_name              = local.vmname_datacenter
  display_name         = local.vmname_datacenter
  guest_os_type        = var.vm_os_type
  version              = var.vm_hardware_version
  cpus                 = var.vm_cpu_sockets
  cores                = var.vm_cpu_cores
  memory               = var.vm_ram
  network_adapter_type = var.vm_nic_type
  network              = var.vm_network
  disk_size            = var.vm_disk_size
  disk_adapter_type    = var.vm_disk_adapter
  disk_type_id         = var.vm_disk_type
  vmdk_name            = local.vmname_datacenter

  # Removable Media Configuration

  iso_url      = "G:\\Microsoft Evaluations\\Windows Server 2022\\SERVER_EVAL_x64FRE_en-us.iso"
  iso_checksum = "md5:E7908933449613EDC97E1B11180429D1"

  floppy_files = [
    "../../bootfiles/win2022/datacenter/autounattend.xml",
    "../../scripts/common/install-vmtools64.ps1",
    "../../scripts/common/initial-setup.ps1",
    "../../scripts/common/unattend.xml",
    "../../scripts/common/sysprep.bat"
  ]

  vmx_data = {
    "firmware"        = "efi",
    "devices.hotplug" = "FALSE"
  }

  # Build Settings
  boot_command = [
    "<spacebar>"
  ]
  boot_wait            = "3s"
  communicator         = "winrm"
  winrm_timeout        = "8h"
  winrm_username       = "Administrator"
  winrm_password       = "VMware1!"
  shutdown_command     = "a:\\sysprep.bat"
  shutdown_timeout     = "1h"
  cleanup_remote_cache = true
  output_directory     = "D:\\Templates\\win2022dc"
  format               = "ova"
}

source "vmware-iso" "win2022dccore" {

  # VM Hardware Configuration

  vm_name              = local.vmname_datacentercore
  display_name         = local.vmname_datacentercore
  guest_os_type        = var.vm_os_type
  version              = var.vm_hardware_version
  cpus                 = var.vm_cpu_sockets
  cores                = var.vm_cpu_cores
  memory               = var.vm_ram
  network_adapter_type = var.vm_nic_type
  network              = var.vm_network
  disk_size            = var.vm_disk_size
  disk_adapter_type    = var.vm_disk_adapter
  disk_type_id         = var.vm_disk_type
  vmdk_name            = local.vmname_datacentercore

  # Removable Media Configuration

  iso_url      = "G:\\Microsoft Evaluations\\Windows Server 2022\\SERVER_EVAL_x64FRE_en-us.iso"
  iso_checksum = "md5:E7908933449613EDC97E1B11180429D1"

  floppy_files = [
    "../../bootfiles/win2022/datacentercore/autounattend.xml",
    "../../scripts/common/install-vmtools64.ps1",
    "../../scripts/common/initial-setup.ps1",
    "../../scripts/common/unattend.xml",
    "../../scripts/common/sysprep.bat"
  ]

  vmx_data = {
    "firmware"        = "efi",
    "devices.hotplug" = "FALSE"
  }

  # Build Settings
  boot_command = [
    "<spacebar>"
  ]
  boot_wait            = "3s"
  communicator         = "winrm"
  winrm_timeout        = "8h"
  winrm_username       = "Administrator"
  winrm_password       = "VMware1!"
  shutdown_command     = "a:\\sysprep.bat"
  shutdown_timeout     = "1h"
  cleanup_remote_cache = true
  output_directory     = "D:\\Templates\\win2022dccore"
  format               = "ova"
}

source "vmware-iso" "win2022std" {

  # VM Hardware Configuration

  vm_name              = local.vmname_standard
  display_name         = local.vmname_standard
  guest_os_type        = var.vm_os_type
  version              = var.vm_hardware_version
  cpus                 = var.vm_cpu_sockets
  cores                = var.vm_cpu_cores
  memory               = var.vm_ram
  network_adapter_type = var.vm_nic_type
  network              = var.vm_network
  disk_size            = var.vm_disk_size
  disk_adapter_type    = var.vm_disk_adapter
  disk_type_id         = var.vm_disk_type
  vmdk_name            = local.vmname_standard

  # Removable Media Configuration

  iso_url      = "G:\\Microsoft Evaluations\\Windows Server 2022\\SERVER_EVAL_x64FRE_en-us.iso"
  iso_checksum = "md5:E7908933449613EDC97E1B11180429D1"

  floppy_files = [
    "../../bootfiles/win2022/standard/autounattend.xml",
    "../../scripts/common/install-vmtools64.ps1",
    "../../scripts/common/initial-setup.ps1",
    "../../scripts/common/unattend.xml",
    "../../scripts/common/sysprep.bat"
  ]

  vmx_data = {
    "firmware"        = "efi",
    "devices.hotplug" = "FALSE"
  }

  # Build Settings
  boot_command = [
    "<spacebar>"
  ]
  boot_wait            = "3s"
  communicator         = "winrm"
  winrm_timeout        = "8h"
  winrm_username       = "Administrator"
  winrm_password       = "VMware1!"
  shutdown_command     = "a:\\sysprep.bat"
  shutdown_timeout     = "1h"
  cleanup_remote_cache = true
  output_directory     = "D:\\Templates\\win2022std"
  format               = "ova"
}

source "vmware-iso" "win2022stdcore" {

  # VM Hardware Configuration

  vm_name              = local.vmname_standardcore
  display_name         = local.vmname_standardcore
  guest_os_type        = var.vm_os_type
  version              = var.vm_hardware_version
  cpus                 = var.vm_cpu_sockets
  cores                = var.vm_cpu_cores
  memory               = var.vm_ram
  network_adapter_type = var.vm_nic_type
  network              = var.vm_network
  disk_size            = var.vm_disk_size
  disk_adapter_type    = var.vm_disk_adapter
  disk_type_id         = var.vm_disk_type
  vmdk_name            = local.vmname_standardcore

  # Removable Media Configuration

  iso_url      = "G:\\Microsoft Evaluations\\Windows Server 2022\\SERVER_EVAL_x64FRE_en-us.iso"
  iso_checksum = "md5:E7908933449613EDC97E1B11180429D1"

  floppy_files = [
    "../../bootfiles/win2022/standardcore/autounattend.xml",
    "../../scripts/common/install-vmtools64.ps1",
    "../../scripts/common/initial-setup.ps1",
    "../../scripts/common/unattend.xml",
    "../../scripts/common/sysprep.bat"
  ]

  vmx_data = {
    "firmware"        = "efi",
    "devices.hotplug" = "FALSE"
  }

  # Build Settings
  boot_command = [
    "<spacebar>"
  ]
  boot_wait            = "3s"
  communicator         = "winrm"
  winrm_timeout        = "8h"
  winrm_username       = "Administrator"
  winrm_password       = "VMware1!"
  shutdown_command     = "a:\\sysprep.bat"
  shutdown_timeout     = "1h"
  cleanup_remote_cache = true
  output_directory     = "D:\\Templates\\win2022stdcore"
  format               = "ova"
}

build {

  name = "Windows Server 2022"
  sources = [
    "source.vmware-iso.win2022dc",
    "source.vmware-iso.win2022dccore",
    "source.vmware-iso.win2022std",
    "source.vmware-iso.win2022stdcore"
  ]

  provisioner "powershell" {
    scripts = [
      "../../scripts/win2022/disable-tls.ps1",
      "../../scripts/win2022/disable-services.ps1",
      "../../scripts/win2022/remove-features.ps1",
      "../../scripts/win2022/config-os.ps1"
    ]
  }

  provisioner "windows-restart" {}

  provisioner "windows-update" {
    pause_before    = "30s"
    search_criteria = "IsInstalled=0"
    filters = ["exclude:$_.Title -like '*VMware*'",
      "exclude:$_.Title -like '*Preview*'",
      "exclude:$_.Title -like '*Defender*'",
      "exclude:$_.InstallationBehavior.CanRequestUserInput",
    "include:$true"]
    restart_timeout = "120m"
  }

  provisioner "windows-restart" {}

}