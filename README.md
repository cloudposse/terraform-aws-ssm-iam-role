# terraform-aws-ssm-iam-role [![Build Status](https://travis-ci.org/cloudposse/terraform-aws-ssm-iam-role.svg?branch=master)](https://travis-ci.org/cloudposse/terraform-aws-ssm-iam-role) [![Slack Community](https://slack.cloudposse.com/badge.svg)](https://slack.cloudposse.com)

Terraform module to provision an IAM role with configurable permissions to access [SSM Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html).

For more information on how to control access to Systems Manager parameters by using AWS Identity and Access Management, see [Controlling Access to Systems Manager Parameters](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-access.html).

__NOTE:__ This module can be used to provision IAM roles for [chamber](https://docs.cloudposse.com/tools/chamber/) with permissions to access SSM parameters.


## Usage

### Basic Example

This example creates a role with the name `cp-prod-app-all` with permission to read all SSM parameters, 
and gives permission to the entities specified in `assume_role_arns` to assume the role.

```hcl
module "ssm_iam_role" {
  source           = "git::https://github.com/cloudposse/terraform-aws-ssm-iam-role.git?ref=master"
  namespace        = "cp"
  stage            = "prod"
  name             = "app"
  attributes       = ["all"]
  assume_role_arns = ["arn:aws:xxxxxxxxxx", "arn:aws:yyyyyyyyyyyy"]
  kms_key_arn      = "arn:aws:kms:us-west-2:123454095951:key/aced568e-3375-4ece-85e5-b35abc46c243"
  ssm_resources    = ["arn:aws:ssm:us-west-2:1234567890:parameter/*"]
  ssm_actions      = ["ssm:GetParametersByPath", "ssm:GetParameters"]
}
```

### Example With Permission For Specific Resources

This example creates a role with the name `cp-prod-app-secrets` with permission to read the SSM parameters that begin with `secret-`, 
and gives permission to the entities specified in `assume_role_arns` to assume the role.

```hcl
module "ssm_iam_role" {
  source           = "git::https://github.com/cloudposse/terraform-aws-ssm-iam-role.git?ref=master"
  namespace        = "cp"
  stage            = "prod"
  name             = "app"
  attributes       = ["secrets"]
  assume_role_arns = ["arn:aws:xxxxxxxxxx", "arn:aws:yyyyyyyyyyyy"]
  kms_key_arn      = "arn:aws:kms:us-west-2:123454095951:key/aced568e-3375-4ece-85e5-b35abc46c243"
  ssm_resources    = ["arn:aws:ssm:us-west-2:1234567890:parameter/secret-*"]
  ssm_actions      = ["ssm:GetParameters"]
}
```

### Complete Example

This example:

* Provisions a KMS key to encrypt SSM Parameter Store secrets using [terraform-aws-kms-key](https://github.com/cloudposse/terraform-aws-kms-key) module
* Performs `Kops` cluster lookup to find the ARNs of `masters` and `nodes` by using [terraform-aws-kops-metadata](https://github.com/cloudposse/terraform-aws-kops-metadata) module
* Creates a role with the name `cp-prod-chamber-kops` with permission to read all SSM parameters from the path `kops`, 
and gives permission to the Kops `masters` and `nodes` to assume the role

```hcl
module "kms_key" {
  source      = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=master"
  namespace   = "cp"
  stage       = "prod"
  name        = "chamber"
  description = "KMS key for SSM"
}

module "kops_metadata" {
  source       = "git::https://github.com/cloudposse/terraform-aws-kops-metadata.git?ref=master"
  dns_zone     = "us-west-2.prod.cloudposse.co"
  masters_name = "masters"
  nodes_name   = "nodes"
}

module "ssm_iam_role" {
  source           = "git::https://github.com/cloudposse/terraform-aws-ssm-iam-role.git?ref=master"
  namespace        = "cp"
  stage            = "prod"
  name             = "chamber"
  attributes       = ["kops"]
  assume_role_arns = ["${module.kops_metadata.masters_role_arn}", "${module.kops_metadata.nodes_role_arn}"]
  kms_key_arn      = "${module.kms_key.key_arn}"
  ssm_resources    = ["arn:aws:ssm:us-west-2:1234567890:parameter/kops/*"]
  ssm_actions      = ["ssm:GetParametersByPath", "ssm:GetParameters"]
}
```


## Variables

|  Name                  |  Default        |  Description                                                                     | Required |
|:-----------------------|:----------------|:---------------------------------------------------------------------------------|:--------:|
| namespace              | ``              | Namespace (_e.g._ `cp` or `cloudposse`)                                          | Yes      |
| stage                  | ``              | Stage (_e.g._ `prod`, `dev`, `staging`)                                          | Yes      |
| name                   | ``              | Name (e.g. `chamber`)                                                            | Yes      |
| kms_key_arn            | ``              | ARN of the KMS key which will decrypt SSM secret strings                         | Yes      |
| assume_role_arns       | ``              | List of ARNs to allow assuming the role. Could be AWS services or accounts, Kops nodes, IAM users or groups    | Yes      |
| ssm_actions            | `["ssm:GetParametersByPath", "ssm:GetParameters"]`   | SSM actions to allow                        |    Yes   |
| ssm_resources          | ``              | SSM resources to apply the actions                                               |    Yes   |
| max_session_duration   | 3600            | The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours               | No       |
| attributes             | `[]`            | Additional attributes (_e.g._ `1`)                                               | No       |
| tags                   | `{}`            | Additional tags  (_e.g._ `map("Cluster","us-east-1.cloudposse.co")`              | No       |
| delimiter              | `-`             | Delimiter to be used between `namespace`, `stage`, `name` and `attributes`       | No       |


## Outputs

| Name              | Description                                         |
|:------------------|:----------------------------------------------------|
| role_name         | The name of the crated role                         |
| role_id           | The stable and unique string identifying the role   |
| role_arn          | The Amazon Resource Name (ARN) specifying the role  |



## Help

**Got a question?**

File a GitHub [issue](https://github.com/cloudposse/terraform-aws-ssm-iam-role/issues), send us an [email](mailto:hello@cloudposse.com) or reach out to us on [Gitter](https://gitter.im/cloudposse/).


## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-ssm-iam-role/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing `terraform-aws-ssm-iam-role`, we would love to hear from you! Shoot us an [email](mailto:hello@cloudposse.com).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

**NOTE:** Be sure to merge the latest from "upstream" before making a pull request!


## License

[APACHE 2.0](LICENSE) © 2018 [Cloud Posse, LLC](https://cloudposse.com)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.


## About

This project is maintained and funded by [Cloud Posse, LLC][website].

![Cloud Posse](https://cloudposse.com/logo-300x69.png)


Like it? Please let us know at <hello@cloudposse.com>

We love [Open Source Software](https://github.com/cloudposse/)!

See [our other projects][community]
or [hire us][hire] to help build your next cloud platform.

  [website]: https://cloudposse.com/
  [community]: https://github.com/cloudposse/
  [hire]: https://cloudposse.com/contact/


## Contributors

| [![Erik Osterman][erik_img]][erik_web]<br/>[Erik Osterman][erik_web] | [![Andriy Knysh][andriy_img]][andriy_web]<br/>[Andriy Knysh][andriy_web] |[![Igor Rodionov][igor_img]][igor_web]<br/>[Igor Rodionov][igor_img]|[![Sarkis Varozian][sarkis_img]][sarkis_web]<br/>[Sarkis Varozian][sarkis_web] |
|-------------------------------------------------------|------------------------------------------------------------------|------------------------------------------------------------------|------------------------------------------------------------------|

[erik_img]: http://s.gravatar.com/avatar/88c480d4f73b813904e00a5695a454cb?s=144
[erik_web]: https://github.com/osterman/
[andriy_img]: https://avatars0.githubusercontent.com/u/7356997?v=4&u=ed9ce1c9151d552d985bdf5546772e14ef7ab617&s=144
[andriy_web]: https://github.com/aknysh/
[igor_img]: http://s.gravatar.com/avatar/bc70834d32ed4517568a1feb0b9be7e2?s=144
[igor_web]: https://github.com/goruha/
[sarkis_img]: https://avatars3.githubusercontent.com/u/42673?s=144&v=4
[sarkis_web]: https://github.com/sarkis/
