locals {
  name1 = "vm"
  name2 = "nat"
  public_instance = "${var.public_name}-${local.name1}"
  privat_instance = "${var.privat_name}-${local.name1}"
  nat_instance = "${local.name2}-${local.name1}"
  ssh-keys = file("~/.ssh/id_ed25519.pub")
}
