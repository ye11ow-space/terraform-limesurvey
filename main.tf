provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "vm" {
  count              = var.vm_num_of_droplets
  ssh_keys           = var.vm_ssh_key_ids
  image              = var.vm_image
  region             = var.do_region
  size               = var.vm_size
  private_networking = var.vm_private_networking
  backups            = var.vm_backups
  monitoring         = var.vm_monitoring
  ipv6               = var.vm_ipv6
  name               = var.vm_name

  provisioner "local-exec" {
    // doesn't listen for a little while after API gives the all-clear
    command = "sleep 25s"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sysctl -p",
      "adduser --disabled-password --gecos '' ${var.ssh_user}",
      "usermod -aG admin ${var.ssh_user}",
      "mkdir -p /home/${var.ssh_user}/.ssh",
      "chmod 0700 /home/${var.ssh_user}/.ssh",
      "cp /root/.ssh/authorized_keys /home/${var.ssh_user}/.ssh",
      "chmod 0600 /home/${var.ssh_user}/.ssh/authorized_keys",
      "chown -R ${var.ssh_user}:${var.ssh_user} /home/${var.ssh_user}",
      "sed -i -e '/Defaults\\s\\+env_reset/a Defaults\\texempt_group=admin/' /etc/sudoers",
      "sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers",
      "visudo -cf /etc/sudoers",
      "sed -i -e 's/#PubkeyAuthentication/PubkeyAuthentication/g' /etc/ssh/sshd_config",
      "sed -i -e 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config",
      "/usr/sbin/sshd -t && systemctl reload sshd",
      "rm -rf /root/.ssh"
    ]
    connection {
      agent       = false
      type        = "ssh"
      private_key = var.ssh_key
      user        = "root"
      timeout     = "5m"
      host        = digitalocean_droplet.vm[count.index].ipv4_address
    }
  }
}
