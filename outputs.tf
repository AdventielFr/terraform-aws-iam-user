
output "user_arn" {
  description = "The ARN assigned by AWS for this user."
  value       = aws_iam_user.this.arn
}

output "user_unique_id" {
  description = "The unique ID assigned by AWS."
  value       = aws_iam_user.this.unique_id
}

output "user_name" {
  description = "The user's name."
  value       = aws_iam_user.this.name
}

output "user_encrypted_password" {
  description = "The encrypted password, base64 encoded."
  value       = join("", aws_iam_user_login_profile.this.*.encrypted_password)
}

output "user_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password."
  value       = join("", aws_iam_user_login_profile.this.*.key_fingerprint)
}

output "user_access_key" {
  description = "The access key ID."
  value       = join("", aws_iam_access_key.this.*.id)
}

output "user_secret_key" {
  description = "The secret access key. Note that this will be written to the state file."
  value       = join("", aws_iam_access_key.this.*.secret)
}