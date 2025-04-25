###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr_public" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "cidr_privat" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

########################################## VPC
variable "vpc_name" {
  type        = string
  default     = "VPC"
  description = "VPC network"
}

variable "public_name" {
  type        = string
  default     = "public"
  description = "public subnet"
}

variable "privat_name" {
  type        = string
  default     = "privat"
  description = "privat subnet"
}



################################# vars nat instance

variable "vm_nat_platform" {
  type        = string
  default     = "standard-v2"
  description = "platform version"
}

variable "vm_nat_preemptible" {
  type        = bool
  default     = true
  description = "preemptible on"
}

variable "nat_image" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
  description = "image_id"
}

variable "nat_ip" {
  type        = string
  default     = "192.168.10.254"
  description = "https://yandex.cloud/ru/docs/compute/operations/vm-control/internal-ip-update"
}

variable "route" {
  type = map
  default = {
      name = "route-table"
      destination_prefix = "0.0.0.0/0"
      next_hop_address = "192.168.10.254"
  }
  description = "https://yandex.cloud/ru/docs/vpc/operations/static-route-create"
}

################################# vars public machine

variable "vm_public_platform" {
  type        = string
  default     = "standard-v2"
  description = "platform version"
}

variable "vm_public_preemptible" {
  type        = bool
  default     = true
  description = "preemptible on"
}


################################# vars privat machine

variable "vm_privat_platform" {
  type        = string
  default     = "standard-v2"
  description = "platform version"
}

variable "vm_privat_preemptible" {
  type        = bool
  default     = true
  description = "preemptible on"
}

################################ vars general

variable "vm_image" {
  type        = string
  default     = "fd874josd3d38p6h0udb"
  description = "image_id"
}

variable "vm_resources" {
  type = map(map(number))
  default = {
    vm_public = {
      cores = 2
      memory = 1
      core_fraction = 5
    }
    vm_privat = {
      cores = 2
      memory = 1
      core_fraction = 5
    }
    nat_instance = {
      cores = 2
      memory = 1
      core_fraction = 5
    }
  }
}
