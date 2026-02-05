resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_user" "app_user" {
  name = "app-user"
  tags = {
    Environment = "dev"
    Owner       = "terraform"
  }
}



resource "aws_iam_user_group_membership" "user_group" {
  user   = aws_iam_user.app_user.name
  groups = [aws_iam_group.developers.name]
}


resource "aws_iam_policy" "s3_read_only" {
  name        = "s3-read-only-policy"
  description = "Policy granting read-only access to S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::*", "arn:aws:s3:::*/*"]
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}
