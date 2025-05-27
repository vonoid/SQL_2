resource "yandex_vpc_network" "network" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.public_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.cidr_public
}




resource "yandex_storage_bucket" "sb" {
  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket                = local.name_date
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-ob.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  anonymous_access_flags {
    read        = true
  }
  website {
    index_document = "index.html"
  }
}


resource "yandex_storage_object" "load-object" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = local.name_date
  key        = "deadline-timeline.png"
  source     = "~/hw_15.3/deadline-timeline.png"
  depends_on = [ yandex_storage_bucket.sb ]
}

resource "yandex_storage_object" "load-index" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = local.name_date
  key        = "index.html"
  source     = "~/hw_15.3/index.html"
  depends_on = [ yandex_storage_bucket.sb ]
}


# resource "yandex_compute_instance_group" "autoscale-group" {
#   name                = local.name
#   service_account_id  = yandex_iam_service_account.sa.id
#   instance_template {

#     platform_id = var.vm_platform
#     resources {
#       memory = var.vm_resources.vm_scale.memory
#       cores  = var.vm_resources.vm_scale.cores
#       core_fraction = var.vm_resources.vm_scale.core_fraction
#     }

#     scheduling_policy {
#       preemptible = var.vm_preemptible
#     }
  
#     boot_disk {
#       mode = "READ_WRITE"
#       initialize_params {
#         image_id = var.vm_image
#         size     = var.vm_resources.vm_scale.size
#       }
#     }

#     network_interface {
#       subnet_ids = [yandex_vpc_subnet.public.id]
#       nat = true
#     }

#     metadata = {
#         ssh-keys = "ubuntu:${local.ssh-keys}"
#         user-data = "${file("update_index.sh")}"
#     }
#   }

#   scale_policy {
#     fixed_scale {
#       size = var.vm_resources.vm_scale.scale_size
#     }
#   }

#   allocation_policy {
#     zones = [var.default_zone]
#   }

#   deploy_policy {
#     max_unavailable = 1
#     max_expansion   = 0
#   }

#   health_check {
# #    healthy_threshold = 2
#     tcp_options {
#       port = 80
#     }
#     interval = 60
#     timeout = 30
#   }

#   load_balancer {
#     target_group_name        = "target-group-${local.name}"
#     target_group_description = "load balancer target group"
#   }
# }




# resource "yandex_lb_network_load_balancer" "nlb" {
#   name = local.name_nlb

#   listener {
#     name = "my-listener"
#     port = 80
#     external_address_spec {
#       ip_version = "ipv4"
#     }
#   }

#   attached_target_group {
#     target_group_id = yandex_compute_instance_group.autoscale-group.load_balancer.0.target_group_id

#     healthcheck {
#       name = "http"
#       http_options {
#         port = 80
#         path = "/"
#       }
#     }
#   }
# }