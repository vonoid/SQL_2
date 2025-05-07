locals {
  name = "lamp"
  name_nlb = "nlb-group"
  ssh-keys = file("~/.ssh/id_ed25519.pub")
  name_date = "nikolai-${formatdate("YYYY.MM.DD",timestamp())}"
}
