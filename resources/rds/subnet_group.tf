resource "aws_db_subnet_group" "subent_group" {
  name       = "saju-private-subnet-group-${terraform.workspace}"
  subnet_ids = var.private_subnet_id

  tags = {
    Name = "saju-private-subnet-group-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}
