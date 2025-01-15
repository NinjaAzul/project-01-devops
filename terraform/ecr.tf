resource "aws_ecr_repository" "devops-ci" {
  name                 = "devops-ci"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    IAC = "True"
  }
}
