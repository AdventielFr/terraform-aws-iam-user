<p align="center">
  <table>
    <tr>
      <td style="text-align: center; vertical-align: middle;"><img src="_docs/logo_aws.jpg"/></td>
      <td style="text-align: center; vertical-align: middle;"><img src="_docs/logo_adv.jpg"/></td>
    </tr>
  <table>
</p>

# AWS IAM User

The purpose of this module is to create an user with iam-rotate-credential.

## Providers

| Name | Version |
|------|---------|
| aws | >=2.8 |
| local | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_region | Aws region | `string` | n/a | yes |
| cli\_access | Allow access AWS Cli if the value is true | `bool` | `true` | no |
| console\_access | Allow access Web AWS console if the value is true | `bool` | `true` | no |
| email | Email of user | `string` | n/a | yes |
| name | User name | `string` | `""` | no |
| password\_reset\_required | Whether the user should be forced to reset the generated password on resource creation. | `bool` | `true` | no |
| policies | List of ARN of policies to set on the user | `list(string)` | `[]` | no |
| public\_key | Allow access Web AWS console if the value is true | `string` | n/a | yes |
| tags | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| user\_access\_key | The access key ID. |
| user\_arn | The ARN assigned by AWS for this user. |
| user\_encrypted\_password | The encrypted password, base64 encoded. |
| user\_key\_fingerprint | The fingerprint of the PGP key used to encrypt the password. |
| user\_name | The user's name. |
| user\_secret\_key | The secret access key. Note that this will be written to the state file. |
| user\_unique\_id | The unique ID assigned by AWS. |

## Usage

`````

module "my_user" {
    source  = "git::https://github.com/AdventielFr/terraform-aws-iam-user.git?ref=1.0.0"
    name = "my-user"
    email = "my-user@no-reply.com"
    aws_region = "eu-west-1"
}

`````
