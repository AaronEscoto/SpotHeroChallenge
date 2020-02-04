variable "instance_count" { default = "3" }

resource "aws_instance" "helloSpotHero" {
  ami   = "${lookup(var.amis, var.region)}"
  count = "${var.instance_count}"
  #availability_zone          = "${var.availability_zones[count.index]}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.web.id}"]
  subnet_id                   = "${aws_subnet.public-subnet-in-us-west-2.id}"
  user_data                   = <<-EOF
                  #!/bin/bash
                  yum update -y
                  yum install -y docker
                  service docker start
                  docker run -d -p 32769:5000 training/webapp python app.py
                EOF
  tags = {
    Name = "helloSpotHero-${count.index}"
  }
}

resource "aws_elb" "helloSpotHero" {
  name    = "helloSpotHero-elb"
  subnets = "${aws_subnet.public-subnet-in-us-west-2[*].id}"
  # The same availability zone as our instances
  listener {
    instance_port     = 32769
    instance_protocol = "http"
    lb_port           = 32769
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    target              = "HTTP:32769/"
    interval            = 300
  }
  # The instances are registered automatically
  instances = "${aws_instance.helloSpotHero[*].id}"
}
