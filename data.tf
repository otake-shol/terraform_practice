data "aws_prefix_list" "s3_pl" {
  name = "com.amazonaws.*.s3"
}

data "aws_ami" "app" {
  most_recent = true
  owners      = ["self", "amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.4.20240429.0-kernel-6.1-x86_64"]
  }
  filter {
    name   = "Root-device-name"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}