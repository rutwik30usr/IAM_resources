output "user" {
  value=aws_iam_user.app_user.name
}

output "group" {
    value = aws_iam_group.developers.name
  
}
