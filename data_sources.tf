data "aws_ami" "this" {
  include_deprecated = true
  owners = [
    "167223888864",
    "self",
    "609525944595",
    "amazon"
  ]
  filter {
    name   = "image-id"
    values = [var.ami_id]
  }
}
data "aws_subnet" "selected" {
  id = var.subnet_id
}

data "aws_caller_identity" "current" {}