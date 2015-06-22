# Configure the CloudStack Provider
provider "cloudstack" {
    api_url = "${var.api_url}"
    api_key = "${var.api_key}"
    secret_key = "${var.secret_key}"
}

resource "cloudstack_vpc" "vpc" {
    name = "DEVOPS_VPC"
    cidr = "10.10.0.0/24"
    vpc_offering = "Default VPC offering"
    zone = "${var.zone}"
}

resource "cloudstack_network_acl" "acl" {
    name = "DEVOPS_NETWORK_ACL"
    vpc = "${cloudstack_vpc.vpc.name}"
}

resource "cloudstack_network_acl_rule" "default-acl-rule" {
  aclid = "${cloudstack_network_acl.acl.id}"

  rule {
    action = "allow"
    source_cidr  = "95.142.96.53/32" # SBPVISITOR 
    protocol = "tcp"
    ports = ["22", "80"]
    traffic_type = "ingress"
  }
}

resource "cloudstack_network" "network" {
    name = "DEVOPS_NETWORK"
    cidr = "10.10.0.0/28"
    network_offering = "${var.offering_network}"
    zone = "${var.zone}"
    vpc = "${cloudstack_vpc.vpc.name}"
    aclid = "${cloudstack_network_acl.acl.id}"
}

resource "cloudstack_ipaddress" "default" {
    vpc = "${cloudstack_vpc.vpc.name}"
}

resource "cloudstack_instance" "webserver" {
    name = "webserver"
    service_offering= "${var.offering_compute}"
    network = "${cloudstack_network.network.name}"
    template = "${var.compute_template}"
    zone ="${var.zone}"
    expunge = true    
}