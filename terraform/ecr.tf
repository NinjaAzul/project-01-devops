resource "aws_ecr_repository" "devops-ci" {
  name                 = "devops-ci"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    IAC = "True"
  }
}
