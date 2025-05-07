output "NLB" {
  value = [
    { connect = ["Public ip: ${yandex_lb_network_load_balancer.nlb.listener.*.external_address_spec[0].*.address[0]}"] },
  ]
}
