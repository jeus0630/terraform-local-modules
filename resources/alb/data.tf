data "aws_instances" "ec2_instances" {
  instance_tags = {
    Name = "saju-api-${terraform.workspace}"
  }
}
