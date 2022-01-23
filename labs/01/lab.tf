resource "google_compute_address" "external_address" {
  count  = var.instance_count
  name   = "${var.subdomain}-${count.index + 1}"
  region = var.gcp_region
}
resource "google_compute_instance" "terra" {
  count        = var.instance_count
  name         = "${var.subdomain}-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.gcp_zone_a
  tags         = ["terralabs"]
  labels = merge({
    name = var.subdomain
    },
    var.default_tags
  )

  boot_disk {
    initialize_params {
      image = data.google_compute_image.master_image.self_link
      size  = var.disk_size
      type  = var.disk_type

      labels = merge({
        name = var.subdomain
        },
        var.default_tags
      )
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.external_address[count.index].address
    }
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.ssh_pub_key)}"
    user-data = templatefile("../conf/template.sh",
      {
        username    = var.username
        external_ip = google_compute_address.external_address[count.index].address
    })
  }
}


