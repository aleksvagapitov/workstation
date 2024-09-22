resource "hcloud_ssh_key" "workstation" {
  name       = "My SSH KEY"
  public_key = file("~/.ssh/workstation.pub")
}

# Create a web server
resource "hcloud_server" "workstation" {
  name        = "jump-server"
  image       = "ubuntu-24.04"
  server_type = "cpx21"
  location    = "ash"
  ssh_keys    = ["My SSH KEY"]

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
