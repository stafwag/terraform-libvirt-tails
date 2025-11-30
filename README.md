# opentofu_terraform_tails_vm

[OpenTofu](https://opentofu.org/)/[Terraform](https://developer.hashicorp.com/terraform)
code to spin up a [Tails](https://tails.net/) libvirt/KVM virtual machine on GNU/Linux.

There're security considerations when you run tails in a virtual machine see:

[https://tails.net/doc/advanced_topics/virtualization/index.en.html](https://tails.net/doc/advanced_topics/virtualization/index.en.html) for more information.

The code in this repository:

* Will check for the latest tails release by reading the JSON feed on
[https://tails.net/install/v2/Tails/amd64/stable/latest.json](https://tails.net/install/v2/Tails/amd64/stable/latest.json)
* Download the latest CDROM image
* Start a libvirt/KVM virtual machine on GNU/Linux

## Requirements

* **libvirt/kvm**: A working libvirt/KVM GNU/Linux system.
* **GnuPg**: The module will donwload the latest tails iso disk image and verify the disk image. ```gpg``` is required for this reason.
* **wget**: ```wget``` is used to download the disk image and signature.

## Module variables

### Input variables

* **name**: The virtual machine name. String. Default: ```mytails```
* **memory**: The virtual machine memory in MB. Number. Default: ```4096```
* **cpus**: The number of vcpus. Number. Default: ```2```
* **tails_iso_path**: The destination path for the disk image. Default: ```~/Downloads```

## Usage

### Basic usage

#### Install OpenTofu or terraform

See: [https://opentofu.org/docs/intro/install/](https://opentofu.org/docs/intro/install/)

#### Import the tails public GnuPG key

Download the tails public GnuPG from: [https://tails.net/tails-signing.key](https://tails.net/tails-signing.key)

```bash
$ wget https://tails.net/tails-signing.key
```

Import the public key.

```
$ gpg --import tails-signing.key
gpg: key DBB802B258ACD84F: 2172 signatures not checked due to missing keys
gpg: key DBB802B258ACD84F: "Tails developers (offline long-term identity key) <tails@boum.org>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1
```

#### Start the virtual machine

##### init

```
$ tofu init
```

##### plan

```
$ tofu plan
```

To set the variables you can use the ```-var``` argument.

```
$ tofu plan -var="name=private_vm" -var="memory=2048" -var="cpus=6"
```

##### apply

```
$ tofu apply
```

To set the variables you can use the ```-var``` argument.

```
$ tofu apply -var="name=private_vm" -var="memory=2048" -var="cpus=6"
```

### Module

### Use the git source

```
module "tails" {
  source = "git::https://github.com/stafwag/terraform-libvirt-tails.git"
  source = "./tails/"
  name  = "my-tails-system"
  memory = 8192
  cpus = 4
  tails_iso_path = "/tmp"
}
```

### Use the registry

The module is published on the [Terraform Registry](https://registry.terraform.io/) and
the [OpenTofu Registry](https://opentofu.org/registry/)


```
module "tails" {
  source = "stafwag/tails/libvirt"
  name  = "my-tails-system"
  memory = 8192
  cpus = 4
  tails_iso_path = "/tmp"
}
```


***Have fun!***
