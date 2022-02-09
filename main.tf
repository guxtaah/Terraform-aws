provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

resource "aws_instance" "k8s" {
  count         = 3
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    name = "k8s${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
}

resource "aws_instance" "k8s4" {
  count         = 1
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    name = "k8s4"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
  depends_on             = [aws_s3_bucket.k8s4]
}

resource "aws_instance" "k8s5" {
  count         = 1
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    name = "k8s5"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
}

resource "aws_instance" "k8s6" {
  provider      = "aws.us-east-2"
  ami           = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    name = "k8s6"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh-us-east-2.id}"]
  depends_on             = ["aws_dynamodb_table.dynamodb-tabela1"]
}

resource "aws_instance" "k8s7" {
  provider      = "aws.us-east-2"
  ami           = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name      = var.key_name
  tags = {
    name = "k8s7"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh-us-east-2.id}"]
  depends_on             = ["aws_dynamodb_table.dynamodb-tabela1"]
}

resource "aws_s3_bucket" "k8s4" {
  bucket = "rmerceslabs-bucket1"
  acl    = "private"

  tags = {
    Name = "rmerceslabs-bucket1"
  }
}

resource "aws_dynamodb_table" "dynamodb-tabela1" {
  provider     = "aws.us-east-2"
  name         = "GameScores"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}