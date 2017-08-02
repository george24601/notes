output "pdAddr" {
  value = "Instances: ${element(aws_instance.pd.*.id, 0)}"
}

output "pdPublic" {
  value = "Public IP: ${element(aws_instance.pd.*.*.public_ip, 0)}"
}

output "pdPrivate" {
  value = "Private IP: ${element(aws_instance.pd.*.*.private_ip, 0)}"
}
