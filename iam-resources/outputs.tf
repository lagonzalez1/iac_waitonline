


// Display role name 
output "iam_codedeploy_role_name" {
    value = aws_iam_role.codedeploy_role.name
}

// Display arn value 
output "iam_codedeploy_role_arn" {
    value = aws_iam_role.codedeploy_role.arn
}