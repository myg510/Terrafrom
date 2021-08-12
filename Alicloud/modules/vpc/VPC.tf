provider "alicloud" {    
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region    = "${var.region}"
}
resource "alicloud_vpc" "vpc" {
  name       = "${var.vpc_name}"
  cidr_block = "${var.cidr_block}"
}

