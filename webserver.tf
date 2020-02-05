variable "instance_count" { default = "3" }
variable warn_threshold { default = 2 }
variable crit_threshold { default = 1 }


resource "aws_instance" "helloSpotHero" {
  ami   = "${lookup(var.amis, var.region)}"
  count = "${var.instance_count}"
  #availability_zone          = "${var.availability_zones[count.index]}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.web.id}"]
  subnet_id                   = "${aws_subnet.public-subnet-in-us-west-2.id}"
  associate_public_ip_address = true
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

resource "aws_elb" "helloSpotHero-elb" {
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

resource "aws_cloudwatch_metric_alarm" "helloSpotHero-alarm" {
  alarm_name                = "helloSpotHero-alarm-CPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  dimensions = {
    LoadBalancer = "helloSpotHero"
  }


}
