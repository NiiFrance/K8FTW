variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "use_name_suffix" {
  description = "Whether to use role, policy, group, user suffixes"
  type        = bool
  default     = true
}

locals {
  role_name   = var.use_name_suffix ? "${var.name_prefix}-role" : var.name_prefix
  policy_name = var.use_name_suffix ? "${var.name_prefix}-policy" : var.name_prefix
  group_name  = var.use_name_suffix ? "${var.name_prefix}-group" : var.name_prefix
  user_name   = var.use_name_suffix ? "${var.name_prefix}-user" : var.name_prefix
}

# IAM Role
resource "aws_iam_role" "this" {
  name = local.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      }
    ]
  })
}

# IAM Policy
resource "aws_iam_policy" "this" {
  name = local.policy_name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Resource = aws_iam_role.this.arn
      }
    ]
  })
}

# IAM Group
resource "aws_iam_group" "this" {
  name = local.group_name
}

# Attach policy to group
resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.this.arn
}

# IAM User
resource "aws_iam_user" "this" {
  name = local.user_name
}

# Add user to group
resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.this.name
  groups = [aws_iam_group.this.name]
}

# Get current account ID
data "aws_caller_identity" "current" {}

output "role_arn" {
  value = aws_iam_role.this.arn
}

output "policy_arn" {
  value = aws_iam_policy.this.arn
}

output "group_name" {
  value = aws_iam_group.this.name
}

output "user_name" {
  value = aws_iam_user.this.name
}