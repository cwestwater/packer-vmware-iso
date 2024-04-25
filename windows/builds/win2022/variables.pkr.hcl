# VM Hardware Configuration

variable "os_family" {
  description = "The OS Family Name"
  type = string
}

variable "vm_os_type" {
  description = "The Guest OS identifier for the VM"
  type        = string
}

variable "vm_hardware_version" {
  description = "The VM hardware version"
  type        = number
}

variable "vm_cpu_sockets" {
  description = "The number of CPU sockets for the VM"
  type        = number
  default     = 2
}

variable "vm_cpu_cores" {
  description = "The number of CPU cores for the VM"
  type        = number
  default     = 1
}

variable "vm_ram" {
  description = "The amount of RAM in Mb for the VM"
  type        = number
  default     = 2048
}

variable "vm_nic_type" {
  description = "The NIC Type (vmxnet3, e1000, etc.) for the VM"
  type        = string
  default     = "vmxnet3"
}

variable "vm_network" {
  description = "The name of the network that the VM will connect to"
  type        = string
}

variable "vm_disk_size" {
  description = "The size of the disk (C:) for the VM"
  type        = number
  default     = 20480
}

variable "vm_disk_adapter" {
  description = "The disk adapter type for the VM"
  type        = string
  default     = "nvme"
}

variable "vm_disk_type" {
  description = "The type of disk"
  type        = string
  default     = "0"
}

# Removable Media Configuration

variable "iso_file_path" {
  description = "The path to the Windows Server 2022 ISO"
  type        = string
}

variable "iso_checksum_value" {
  description = "The path to the the Windows Server 2022 ISO"
  type        = string
}

# Build Settings

variable "template_path" {
  description = "The path to place the template"
  type        = string
}

variable "template_output_format" {
  description = "The format of the template to output - ovf, ova or vmx"
  type        = string
  default     = "ova"
}

locals {
  vmname_datacenter = "${var.os_family}dc"
  vmname_datacentercore = "${var.os_family}dccore"
  vmname_standard = "${var.os_family}std"
  vmname_standardcore = "${var.os_family}stdcore"
}