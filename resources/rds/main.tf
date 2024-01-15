resource "aws_db_instance" "rds" {
  identifier             = "saju-db-${terraform.workspace}"
  db_subnet_group_name   = aws_db_subnet_group.subent_group.id
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = lookup(var.instance_class, terraform.workspace)
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.mysql8.0"
  allocated_storage      = 20
  max_allocated_storage  = 1000
  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = [aws_security_group.sg.id]
  availability_zone      = "ap-northeast-2c"
  port                   = 3306
  skip_final_snapshot    = true
  tags = {
    Name    = "saju-db-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}
