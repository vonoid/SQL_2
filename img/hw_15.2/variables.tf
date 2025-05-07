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


########################################## VPC

variable "vpc_name" {
  type        = string
  default     = "NB"
  description = "VPC network"
}

variable "public_name" {
  type        = string
  default     = "public"
  description = "public subnet"
}



variable "vm_image" {
  type        = string
  default     = "fd827b91d99psvq5fjit"
  description = "image_id"
}

variable "vm_resources" {
  type = map(map(number))
  default = {
    vm_scale = {
      cores = 2
      memory = 1
      core_fraction = 5
      size = 8
      scale_size = 3
    }
  }
}

variable "vm_preemptible" {
  type        = bool
  default     = true
  description = "preemptible on"
}


variable "vm_platform" {
  type        = string
  default     = "standard-v2"
  description = "platform version"
}
