output "public_ip" {
 value = [hcloud_server.workstation.ipv4_address]
}