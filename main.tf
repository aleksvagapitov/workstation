terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.28.1"
    }
  }
}

variable "do_api_token" {}

resource "digitalocean_ssh_key" "workstation" {
  name       = "workstation_key"
  public_key = file("~/.ssh/workstation.pub")
}

provider "digitalocean" {
  token = var.do_api_token
}

# Create a web server
resource "digitalocean_droplet" "workstation" {
  image       = "ubuntu-22-04-x64"
  name        = "workstation"
  region      = "sgp1"
  size        = "s-1vcpu-2gb"
  ssh_keys    = [digitalocean_ssh_key.workstation.id]

  provisioner "remote-exec" {
    script = "scripts/remote-config.sh"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/workstation")
      user        = "root"
      timeout     = "2m"
    }
  }
  
  provisioner "file" {
    source      = "server"
    destination = ".server/"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/workstation")
      user        = "user"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "scripts"
    destination = ".scripts/"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/workstation")
      user        = "user"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "~/.ssh/github"
    destination = ".ssh/github"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/workstation")
      user        = "user"
      timeout     = "2m"
    }
  }
}

output "public_ip" {
  value = "ssh -i ~/.ssh/workstation user@${digitalocean_droplet.workstation.ipv4_address}"
}

output "copy_ssh_file" {
  value = "scp -i ~/.ssh/workstation ~/.ssh/github user@${digitalocean_droplet.workstation.ipv4_address}:/home/user/.ssh/"
}

output "copy_vpn_file" {
  value = "scp -i ~/.ssh/workstation user@${digitalocean_droplet.workstation.ipv4_address}:client.ovpn ~/Desktop"
}
