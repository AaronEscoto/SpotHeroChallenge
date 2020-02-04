resource "aws_subnet" "public-subnet-in-us-west-2" {
  vpc_id = "${aws_vpc.default.id}"

  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "us-west-2a"

  tags = {
    Name = "publicSubnet"
  }
}
