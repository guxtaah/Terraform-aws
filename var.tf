variable "amis" {
  type = map(string)

  default = {
    "us-east-1" = "ami-0e472ba40eb589f49"
    "us-east-2" = "ami-03a0c45ebc70f98ea"
  }
}

variable "cdirs_acesso_remoto" {
  type    = list(string)
  default = ["201.13.100.80/32"]
}

variable "key_name" {
  default = "aws01"
}