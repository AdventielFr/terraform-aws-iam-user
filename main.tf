provider "aws" {
  version = ">=2.8"
  region  = var.aws_region
}

resource "random_string" "random" {
  length  = 16
  special = false
  lower   = true
  number  = true
  upper   = false
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    name = local.name
  }
}


#--------------------------------------------------------------------------
# Data 
#--------------------------------------------------------------------------
data "local_file" "this" {
  filename = var.public_key
}

#--------------------------------------------------------------------------
# Local variables
#--------------------------------------------------------------------------
locals {
  gpg_public_key = data.local_file.this.content
  name           = var.name == "" ? var.email : var.name
}

#--------------------------------------------------------------------------
# IAM User
#--------------------------------------------------------------------------
resource "aws_iam_user" "this" {
  name = local.name
  tags = merge(var.tags, map("IamRotateCredentials:Email", var.email))
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

#--------------------------------------------------------------------------
# IAM User Access Key
#--------------------------------------------------------------------------
resource "aws_iam_access_key" "this" {
  count = var.cli_access ? 1 : 0
  user  = aws_iam_user.this.name
}

#--------------------------------------------------------------------------
# IAM User Login Profile
#--------------------------------------------------------------------------
resource "aws_iam_user_login_profile" "this" {
  count                   = var.console_access ? 1 : 0
  user                    = aws_iam_user.this.name
  pgp_key                 = local.gpg_public_key
  password_length         = "16"
  password_reset_required = var.password_reset_required
  depends_on = [
    aws_iam_user.this
  ]
  lifecycle {
    ignore_changes = [
      password_reset_required,
    ]
  }
}

#--------------------------------------------------------------------------
# IAM policies attachment
#--------------------------------------------------------------------------

resource "aws_iam_policy_attachment" "policy_attachment" {
  count = length(var.policies)
  name  = "Policy attachment ${aws_iam_user.this.name} - ${random_string.random.result}"
  users = [
    aws_iam_user.this.name
  ]
  policy_arn = element(var.policies, count.index)
  depends_on = [
    aws_iam_user.this
  ]
}


