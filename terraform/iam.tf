resource "aws_iam_openid_connect_provider" "oidc-git" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com"
  ]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]

  tags = {
    IAC = "True"
  }
}


resource "aws_iam_role" "github-actions-role" {

  name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRoleWithWebIdentity"
        Principal = {
          Federated = "arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"
        }
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = [
              "sts.amazonaws.com"
            ]
            "token.actions.githubusercontent.com:sub" = [
              "repo:NinjaAzul/project-01-devops:ref:refs/heads/main"
            ]
          }
        }
      }
    ]


  })

  inline_policy {
    name = "github-actions-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Sid      = "Statement1"
        Effect   = "Allow"
        Action   = "apprunner:*"
        Resource = "*"
        },
        {
          Sid = "Statement2"
          Action = [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:PutImage",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload",
            "ecr:GetAuthorizationToken",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Sid      = "Statement3"
          Effect   = "Allow"
          Action   = ["iam:PassRole", "iam:CreateServiceLinkedRole"]
          Resource = "*"
        }
      ]
    })
  }
  tags = {
    IAC = "True"
  }
}

resource "aws_iam_role" "app-runner-role" {
  name = "app-runner-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "build.apprunner.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
  tags = {
    IAC = "True"
  }
}
