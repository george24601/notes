data "aws_availability_zones" "available" {}

data "aws_ami" "amazon-linux-2" {
 most_recent = true

 owners = ["amazon"]

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm-*-x86_64-gp2"]
 }
}

data "template_file" "tidb_cluster_values" {
  template = "${file("${path.module}/templates/tidb-cluster-values.yaml.tpl")}"
  vars  {
    cluster_version = "${var.tidb_version}"
    pd_replicas = "${var.pd_count}"
    tikv_replicas = "${var.tikv_count}"
    tidb_replicas = "${var.tidb_count}"
    monitor_enable_anonymous_user = "${var.monitor_enable_anonymous_user}"
  }
}

resource "local_file" "tidb_cluster_values" {
  content = "${data.template_file.tidb_cluster_values.rendered}"
  filename = "${path.module}/tidb_cluster_values.yaml"
}
