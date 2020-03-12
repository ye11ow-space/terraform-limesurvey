// these must be modified or set at runtime
variable "do_token" {}
variable "do_region" {}
variable "ssh_user" {}
variable "vm_ssh_key_ids" { type = list }
variable "ssh_key" {}
variable "vm_name" {}

variable "vm_num_of_droplets" {
  default = 1
}
variable "vm_image" {
  default = "ubuntu-18-04-x64"
}
variable "vm_size" {
  default = "s-1vcpu-1gb"
}
variable "vm_private_networking" {
  default = false
}
variable "vm_backups" {
  default = false
}
variable "vm_monitoring" {
  default = false
}
variable "vm_ipv6" {
  default = false
}

