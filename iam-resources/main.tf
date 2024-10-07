resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AmazonEC2RoleforAWSCodeDeploy policy
resource "aws_iam_role_policy_attachment" "codedeploy_full" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
  role       = aws_iam_role.codedeploy_role.name
}

# Attach AmazonEC2RoleforAWSCodeDeployLimited policy
resource "aws_iam_role_policy_attachment" "codedeploy_limited" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeployLimited"
  role       = aws_iam_role.codedeploy_role.name
}

# Attach AmazonEC2ContainerRegistryReadOnly policy (corrected ARN)
resource "aws_iam_role_policy_attachment" "codedeploy_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.codedeploy_role.name
}

# Attach AmazonS3FullAccess policy (corrected ARN)
resource "aws_iam_role_policy_attachment" "codedeploy_s3_full" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.codedeploy_role.name
}

# Attach AutoScalingFullAccess policy (corrected ARN)
resource "aws_iam_role_policy_attachment" "codedeploy_autoscale_full" {
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
  role       = aws_iam_role.codedeploy_role.name
}

# Attach AWSCodeDeployRole policy (no changes here)
resource "aws_iam_role_policy_attachment" "codedeploy_deploy_full" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.codedeploy_role.name
}

# Output the ARN of the created role
output "codedeploy_role_arn" {
  value       = aws_iam_role.codedeploy_role.arn
  description = "The ARN of the IAM role for CodeDeploy"
}
