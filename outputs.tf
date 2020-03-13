// https://www.terraform.io/docs/providers/do/r/droplet.html#attributes-reference
output "Name" { value = "${digitalocean_droplet.vm.*.name}" }
output "Droplet_ID" { value = "${digitalocean_droplet.vm.*.id}" }
output "IPv4_Address_Public" { value = "${digitalocean_droplet.vm.*.ipv4_address}" }
output "Status" { value = "${digitalocean_droplet.vm.*.status}" }
