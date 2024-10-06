
resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}