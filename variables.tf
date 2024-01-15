variable "instance_type" {
  type = map(string)
  default = {
    default = "t2.micro"
    dev     = "t2.micro"
    prod    = "t3.medium"
  }
}

variable "volume_size" {
  type = map(number)
  default = {
    default = 30
    dev     = 30
    prod    = 100
  }
}

variable "volume_type" {
  type = map(string)
  default = {
    default = "gp2"
    dev     = "gp2"
    prod    = "gp2"
  }
}

variable "instance_class" {
  type = map(string)
  default = {
    default = "db.t2.micro"
    dev     = "db.t2.micro"
    prod    = "db.t3.medium"
  }
}

variable "username" {
  type = string

  default = "admin"
}

variable "password" {
  type = string
}

variable "bucket" {
  type = string
}

variable "publicly_accessible" {
  type = bool
}

variable "index_document" {
  type = string

  default = "index.html"
}

variable "error_document" {
  type = string

  default = "error.html"
}

variable "subnet_count" {
  type = number

  default = 2
}
