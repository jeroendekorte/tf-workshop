variable "zone" {}
variable "vpc" {}
variable "offering_compute" {}
variable "compute_template" {}
variable "offering_network" {}

resource "cloudstack_network_acl" "acl" {
    name = "DEVOPS_NETWORK_ACL_DB"
    vpc = "${var.vpc}"
}

resource "cloudstack_network_acl_rule" "default-acl-rule" {
  aclid = "${cloudstack_network_acl.acl.id}"

  rule {
    action = "allow"
    source_cidr  = "95.142.96.53/32" # SBPVISITOR 
    protocol = "tcp"
    ports = ["22"]
    traffic_type = "ingress"
  }
  rule {
    action = "allow"
    source_cidr  = "83.84.22.34/32" # HOME 
    protocol = "tcp"
    ports = ["22", "80"]
    traffic_type = "ingress"
  }
  rule {
    action = "allow"
    source_cidr  = "10.10.0.0/24" # Web Access 
    protocol = "tcp"
    ports = ["3306", "22"]
    traffic_type = "ingress"
  }
}

resource "cloudstack_network" "network" {
    name = "DEVOPS_NETWORK_DB"
    cidr = "10.10.0.65/28"
    network_offering = "${var.offering_network}"
    zone = "${var.zone}"
    vpc = "${var.vpc}"
    aclid = "${cloudstack_network_acl.acl.id}"
}

resource "cloudstack_ipaddress" "default" {
    vpc = "${var.vpc}"
}

resource "cloudstack_instance" "dbserver" {
    name = "dbserver"
    service_offering= "${var.offering_compute}"
    network = "${cloudstack_network.network.name}"
    template = "${var.compute_template}"
    zone ="${var.zone}"
    expunge = true    
}

resource "cloudstack_port_forward" "default" {
    ipaddress = "${cloudstack_ipaddress.default.ipaddress}"

    forward {
        protocol = "tcp"
        private_port = 22
        public_port = 22
        virtual_machine = "dbserver"
    }

    connection {
        user = "bootstrap"
        key_file = "../../bootstrap.key"
        host = "${cloudstack_ipaddress.default.ipaddress}"
    }

    provisioner "file" {
        source = "${path.module}/scripts/tasks.sql"
        destination = "/tmp/tasks.sql"
    }

    provisioner "remote-exec" {
        script = "${path.module}/scripts/mariadb.sh"
    }

    depends_on = ["cloudstack_instance.dbserver"]
}

output "dbserver_ip" {
    value = "cloudstack_instance.dbserver.ipaddress"
}