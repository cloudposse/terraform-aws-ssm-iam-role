
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account_id | AWS account ID | string | - | yes |
| assume_role_arns | List of ARNs to allow assuming the role. Could be AWS services or accounts, Kops nodes, IAM users or groups | list | - | yes |
| attributes | Additional attributes (e.g. `1`) | list | `<list>` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| kms_key_arn | ARN of the KMS key which will encrypt/decrypt SSM secret strings | string | - | yes |
| max_session_duration | The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours | string | `3600` | no |
| name | Name (e.g. `app` or `chamber`) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| region | AWS Region | string | - | yes |
| ssm_actions | SSM actions to allow | list | `<list>` | no |
| ssm_parameters | List of SSM parameters to apply the actions. A parameter can include a path and a name pattern that you define by using forward slashes, e.g. `kops/secret-*` | list | - | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_arn | The Amazon Resource Name (ARN) specifying the role |
| role_id | The stable and unique string identifying the role |
| role_name | The name of the crated role |

