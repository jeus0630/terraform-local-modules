resource "aws_instance" "ec2" {
  ami                    = data.aws_ami_ids.ami_id.ids[0]
  instance_type          = lookup(var.instance_type, terraform.workspace)
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = var.private_subnet_id
  availability_zone      = "ap-northeast-2c"
  user_data              = file("./ec2/ec2_userdata.sh")

  root_block_device {
    volume_size = lookup(var.volume_size, terraform.workspace)
    volume_type = lookup(var.volume_type, terraform.workspace)
  }

  tags = {
    Name    = "saju-api-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}
