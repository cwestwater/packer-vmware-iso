# HashiCorp Packer with VMware Workstation to build Windows Server Images

This repo hosts a set of files to build Windows Server 2022 Operating Systems in a VMware vSphere environment using [HashiCorp Packer](https://www.packer.io/) using the [vmware-iso](https://developer.hashicorp.com/packer/integrations/hashicorp/vmware/latest/components/builder/iso) builder.

## OS Versions

The OS ISO used are obtained from the [Microsoft Evaluation Center](https://www.microsoft.com/en-gb/evalcenter/evaluate-windows-server), specifically:

- [Windows Server 2022](https://www.microsoft.com/en-gb/evalcenter/evaluate-windows-server-2022)

## Packer and Modules Versions

The version of Packer, the [vmware-iso](https://developer.hashicorp.com/packer/integrations/hashicorp/vmware/latest/components/builder/iso) plugin to be used is defined in the first section of the `win2022.pkr.hcl` file:

```terraform
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
```

Packer should be downloaded from the [Packer Downloads](https://www.packer.io/downloads) page and installed appropriately. See the [Install Packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) tutorial.

## autounattend.xml Boot Files

The `autounattend.xml` files are located in the `bootfiles\win2022` folder.

This file is used to perform initial boot of the OS and perform such tasks as partition the disk, set regional options, select the OS version, etc. These are best edited using the [Windows System Image Manager](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/windows-system-image-manager-technical-reference) which is part of [Windows ADK](https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install).

The autounattend files specifically perform these steps:

- Set Regional options to `en-GB` - Lines 7-11
- Partition the disk to suite a EFI layout - Line 14-67
- Choose the OS to install - Line 73
- Sets Name and Organisation - Lines 83-84, 100-101
- Loads the PVSCSI driver - Line 89-93
- Sets the computer name - Line 98
- Sets the Time Zone - Line 99
- Sets the PowerShell Execution Policy - Lines 123-133
- Disable network discovery prompt for all users - Lines 134-138
- Turn on network discovery for all network profiles - Lines 139-143
- Calls the script `install-vmtools64.ps1` to install VMware Tools - Lines 144-148
- Calls the script `initial-setup.ps1` which sets up PowerShell and WinRM - Lines 149-153
- Sets the local Administrator Account password - Line 163

> You will see the local Administrator account shown in clear text. You should use WSIM to set your own password and use WISM to encrypt it. See [Hide Sensitive Data in an Answer File](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/hide-sensitive-data-in-an-answer-file)

These are pretty standard. The parts added to work with Packer/vSphere is the script `install-vmtools64.ps1`.

## Packer HCL Files

The Packer specific files are located in the `builds` folder.

These files are written using [HashiCorp HCL2](https://www.packer.io/guides/hcl) which is the preferred way to write Packer builds. This is made up of three files:

- variables.pkr.hcl - defines all the variables used in the build
- win2022.auto.pkrvar.hcl - the values for all the variables defined above
- win2022.pkr.hcl - the build definition for the OS

To be able to run the builds in your environment you need to fill in the missing values in the `win2022.auto.pkrvars.hcl` file:

```terraform
# VM Hardware Configuration

os_family = "win2022"
vm_os_type = "windows2019srvnext-64"
vm_hardware_version = 21
vm_cpu_sockets = 1
vm_cpu_cores = 1
vm_ram = 2048
vm_nic_type = "vmxnet3"
vm_network = "NAT"
vm_disk_size = 81920
vm_disk_adapter = "nvme"
vm_disk_type = "0"

# Removable Media Configuration

iso_file_path = "G:\\Microsoft Evaluations\\Windows Server 2022\\SERVER_EVAL_x64FRE_en-us.iso"
iso_checksum_value = "md5:E7908933449613EDC97E1B11180429D1"

# Build Settings

template_path = "D:\\Templates"
```

Look in the `variables.pkr.hcl` file for details on each variable.

The build of the VM is defined in the `win2022.pkr.hcl` files. The file is split into the 'sections':

- vCenter credentials
- vCenter details - which vCenter, datastore, network,, etc. to build on
- VM Hardware Configuration - the hardware settings for the VM
- Removable Media Configuration - the details of the OS and VMware Tools ISO
- Build Settings - items such as the boot command, winrm connection, shutdown command, etc.
- Provisioner Settings - the scripts used to setup the OS and Windows Update plugin

Each of the Operating System `win*.pkr.hcl` files has four options:

- Datacenter
- Datacenter Core
- Standard
- Standard Core

## How to Run

Once all variables have a value in the `win2022.auto.pkrvars.hcl` file browse to the OS `build` folder you want to run. Run the following command:

```dosbatch
packer build -force .
```

Note the `.` at the end of the command. This makes Packer process all the files in the folder.

Each of these commands will build all four OS versions. If you want to target a particular OS version you can use the following command (Windows Server 2022 Standard as an example):

```dosbatch
packer build -force -only "Windows Server 2022.vmware-iso.win2022dc" .
```

## OS Customisation

Once the VMs have completed initial setup and Packer can connect using WinRM, four PowerShell scripts are run to perform the following:

- Disable TLS 1.0 and 1.1
- Removes various features
- Disables services Microsoft recommends
- Performs some general OS customisations

These scripts are found in the `scripts` folder.

## A Note on Credentials

The credentials needed to successfully build are as follows:

- WinRM username and password - the variables `var.winrm_username` and `var.winrm_password`
- Local Administrator account username and password - found in the `autounattend.xml` files

Important - the WinRM username and password should match the Local Administrator account username and password as this is what Packer uses to connect to the VM for customisation. In the files in this repo I have added the local Administrator account password in clear text. Please use WSIM to hide the password.

Please see [Template User Variables](https://www.packer.io/docs/templates/legacy_json_templates/user-variables) in the Packer documentation for more details.
