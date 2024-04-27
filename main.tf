provider "aws" {
  profile =  "terraform"
  region = "ap-northeast-1"
}

resource "aws_instance" "hello-world" {
  ami = "ami-04e0b6d6cfa432943"
  instance_type = "t2.micro"

  tags =  {
    Name = "hellowolrd"
  }

  user_data = <<EOF
#!/bin/bash
amazon-linux-extras install -y nginx1.12
systemctl start nginx
EOF
}


