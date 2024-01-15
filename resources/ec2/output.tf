output "ec2_instance" {
  value = aws_instance.ec2.public_ip
}
