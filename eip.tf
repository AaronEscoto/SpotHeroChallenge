resource "aws_eip" "nat" {
  instance = "${aws_instance.nat.id}"
  vpc      = true
}

resource "aws_eip" "helloSpotHero" {
  instance = "${aws_instance.helloSpotHero[0].id}"
  vpc      = true
}
