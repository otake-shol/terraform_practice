resource "aws_instance" "server" {
  ami           = ""
  instance_type = var.instance_type
  tags = {
    name = "test"
  }
  user_data = <<EOF
    #!/bin/bash
    amazon-linux-extras install -y nginx1.12
    systemctl start nginx
    EOF

}