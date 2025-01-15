resource "aws_iam_role" "github-actions-role" {
  name = "github-actions-role"

  # Separar assume_role_policy do inline_policy
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
            "token.actions.githubusercontent.com:aud" = ["sts.amazonaws.com"]
            "token.actions.githubusercontent.com:sub" = ["repo:NinjaAzul/project-01-devops:ref:refs/heads/main"]
          }
        }
      }
    ]
  })

  # Adicionar inline_policy como um recurso separado
  inline_policy {
    name = "github-actions-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid = "Statement1"
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
        }
      ]
    })
  }

  tags = {
    IAC = "True"
  }
}
