
output "lab-ssh" {
  value = "ssh ${var.username}@${google_compute_instance.terra[0].network_interface.0.access_config.0.nat_ip} -i ~/Documents/code/dockerlabs/labs/keys/prod/dockerlabkey"
}

output "local-ip" {
	value = google_compute_instance.terra[0].network_interface.0.network_ip
}

output "IP-list" {
  value = "${google_compute_instance.terra[*].network_interface.0.access_config.0.nat_ip}"
}

output "names" {
  value = google_compute_instance.terra[*].name
}
