variable "vpc_id" {
  type = string
}

variable "instance_type" {
  type = map(string)
}

variable "volume_size" {
  type = map(number)
}

variable "volume_type" {
  type = map(string)
}

variable "private_subnet_id" {
  type = string
}
