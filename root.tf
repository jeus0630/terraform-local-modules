module "vpc" {
  source       = "./vpc"
  subnet_count = var.subnet_count
}

module "ec2" {
  source            = "./ec2"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id[0]
  instance_type     = var.instance_type
  volume_size       = var.volume_size
  volume_type       = var.volume_type
}

module "rds" {
  source              = "./rds"
  vpc_id              = module.vpc.vpc_id
  instance_class      = var.instance_class
  username            = var.username
  password            = var.password
  publicly_accessible = var.publicly_accessible
  private_subnet_id   = module.vpc.private_subnet_id
}

module "s3" {
  source         = "./s3"
  bucket         = var.bucket
  index_document = var.index_document
  error_document = var.error_document
}

module "alb" {
  # depends_on = [module.ec2]

  source            = "./alb"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  public_subnet_id  = module.vpc.public_subnet_id
}
