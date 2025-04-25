output "VM" {
  value = [
    { nat = ["Name Machine: ${yandex_compute_instance.nat.name}","Public ip: ${yandex_compute_instance.nat.network_interface[0].nat_ip_address}","Local ip: ${yandex_compute_instance.nat.network_interface[0].ip_address}"] },
    { public = ["Name Machine: ${yandex_compute_instance.public.name}","Public ip: ${yandex_compute_instance.public.network_interface[0].nat_ip_address}","Local ip: ${yandex_compute_instance.public.network_interface[0].ip_address}"] },
    { privat = ["Name Machine: ${yandex_compute_instance.privat.name}","Public ip: ${yandex_compute_instance.privat.network_interface[0].nat_ip_address}","Local ip: ${yandex_compute_instance.privat.network_interface[0].ip_address}"] }
  ]
}
