resource "aws_instance" "web" {
  count                       = length(var.subnet_ids)
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = var.subnet_ids[count.index]
  vpc_security_group_ids      = [var.sg_id]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd

    export META_INST_ID=`curl http://169.254.169.254/latest/meta-data/instance-id`
    export META_INST_TYPE=`curl http://169.254.169.254/latest/meta-data/instance-type`
    export META_INST_AZ=`curl http://169.254.169.254/latest/meta-data/placement/availability-zone`

    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello, World!</h1>" > /var/www/html/index.html
    echo "<p>Instance ID: $META_INST_ID</p>" >> /var/www/html/index.html
    echo "<p>Instance Type: $META_INST_TYPE</p>" >> /var/www/html/index.html
    echo "<p>Availability Zone: $META_INST_AZ</p>" >> /var/www/html/index.html
  EOF

  tags = {
    Name = "web-${count.index}"
  }
}