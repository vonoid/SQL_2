resource "yandex_vpc_network" "network" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.public_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.cidr_public
}

resource "yandex_vpc_subnet" "privat" {
  name           = var.privat_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.cidr_privat
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_route_table" "route-table" {
  name       = var.route.name
  network_id = yandex_vpc_network.network.id
  static_route {
    destination_prefix = var.route.destination_prefix
    next_hop_address   = var.route.next_hop_address
  }
}




resource "yandex_compute_instance" "nat" {
  name        = local.nat_instance
  platform_id = var.vm_nat_platform
  resources {
    cores         = var.vm_resources.nat_instance.cores
    memory        = var.vm_resources.nat_instance.memory
    core_fraction = var.vm_resources.nat_instance.core_fraction
  }
  scheduling_policy {
    preemptible = var.vm_nat_preemptible
  }
  boot_disk {
    initialize_params {
      image_id = var.nat_image
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
    ip_address = var.nat_ip
  }
  metadata = {
    ssh-keys = "debian:${local.ssh-keys}"
  }

}




resource "yandex_compute_instance" "public" {
  name        = local.public_instance
  platform_id = var.vm_public_platform
  resources {
    cores         = var.vm_resources.vm_public.cores
    memory        = var.vm_resources.vm_public.memory
    core_fraction = var.vm_resources.vm_public.core_fraction
  }
  scheduling_policy {
    preemptible = var.vm_public_preemptible
  }
  boot_disk {
    initialize_params {
      image_id = var.vm_image
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }
  metadata = {
    ssh-keys = "debian:${local.ssh-keys}"
  }

}




resource "yandex_compute_instance" "privat" {
  name        = local.privat_instance
  platform_id = var.vm_privat_platform
  resources {
    cores         = var.vm_resources.vm_privat.cores
    memory        = var.vm_resources.vm_privat.memory
    core_fraction = var.vm_resources.vm_privat.core_fraction
  }
  scheduling_policy {
    preemptible = var.vm_privat_preemptible
  }
  boot_disk {
    initialize_params {
      image_id = var.vm_image
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.privat.id
  }

  metadata = {
    ssh-keys = "debian:${local.ssh-keys}"
  }

}