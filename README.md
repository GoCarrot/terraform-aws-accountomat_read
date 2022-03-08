# Accountomat Read

Accountomat Read reads data peristed by [Accountomat](https:://github.com/GoCarrot/terraform-aws-accountomat) and provides it for use in terraform modules.

## Example usage
```hcl
# Configure an account in one module.
resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

resource "aws_ssm_parameter" "org_prefix" {
  name  = "/omat/organization_prefix"
  type  = "String"
  value = "teak"
}

module "sandbox_account" {
  source = "GoCarrot/aws/accountomat"

  name        = "sandbox-0001"
  environment = "development"
  purpose     = "sandbox"
  slug        = "sandbox-0001"
  email       = "alex@teak.io"
  parent_id   = aws_organizations_organization.org.roots[0].id

  depends_on = [aws_ssm_parameter.org_prefix]
}

output "sandbox_slug" {
  value = module.sandbox_account.canonical_slug
}
```

```hcl
# Read details from the account and thunk into that account in another module.
provider "aws" {
  alias = "meta"
}

module "current_account" {
  source = "GoCarrot/accountomat_read/aws"

  providers = {
    aws = aws.meta
  }

  canonical_slug = terraform.workspace
}

provider "aws" {
  assume_role {
    role_arn = module.current_account.roles["admin"]
  }
}

resource "aws_ssm_parameter" "configuration" {
  provider = aws.meta

  name  = "${module.current_account.param_prefix}/config/Hello"
  type  = "String"
  value = "World"
}

resource "aws_cloudwatch_log_group" "foo" {
  name = "/${module.current_account.organization_prefix}/server/${module.current_account.environment}/service/foo"
}
```
