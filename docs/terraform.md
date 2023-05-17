<!-- markdownlint-disable -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_label"></a> [label](#module\_label) | git::https://github.com/cloudposse/terraform-terraform-label.git | 0.1.3 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS account ID | `string` | n/a | yes |
| <a name="input_assume_role_arns"></a> [assume\_role\_arns](#input\_assume\_role\_arns) | List of ARNs to allow assuming the role. Could be AWS services or accounts, Kops nodes, IAM users or groups | `list(string)` | n/a | yes |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| <a name="input_kms_key_reference"></a> [kms\_key\_reference](#input\_kms\_key\_reference) | The Key ID, Key ARN, Key Alias Name, or Key Alias ARN of the KMS key which will encrypt/decrypt SSM secret strings | `any` | n/a | yes |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours | `number` | `3600` | no |
| <a name="input_name"></a> [name](#input\_name) | Name (e.g. `app` or `chamber`) | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace (e.g. `cp` or `cloudposse`) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_ssm_actions"></a> [ssm\_actions](#input\_ssm\_actions) | SSM actions to allow | `list(string)` | <pre>[<br>  "ssm:GetParametersByPath",<br>  "ssm:GetParameters"<br>]</pre> | no |
| <a name="input_ssm_parameters"></a> [ssm\_parameters](#input\_ssm\_parameters) | List of SSM parameters to apply the actions. A parameter can include a path and a name pattern that you define by using forward slashes, e.g. `kops/secret-*` | `list(string)` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage (e.g. `prod`, `dev`, `staging`) | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The Amazon Resource Name (ARN) specifying the role |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | The stable and unique string identifying the role |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The name of the crated role |
| <a name="output_role_policy_document"></a> [role\_policy\_document](#output\_role\_policy\_document) | A copy of the IAM policy document (JSON) that grants permissions to this role. |
<!-- markdownlint-restore -->
