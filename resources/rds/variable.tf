variable "vpc_id" {
  type = string
}

variable "instance_class" {
  type = map(string)
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "publicly_accessible" {
  type = bool
}

variable "private_subnet_id" {
  type = list(string)
}
