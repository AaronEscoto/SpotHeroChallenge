resource "aws_instance" "nat" {
  ami                         = "ami-0541ea7d"
  availability_zone           = "us-west-2a"
  instance_type               = "t2.micro"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.nat.id}"]
  subnet_id                   = "${aws_subnet.public-subnet-in-us-west-2.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name = "NAT"
  }
}
