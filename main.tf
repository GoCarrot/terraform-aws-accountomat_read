# Copyright 2022 Teak.io, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3, < 5"
    }
  }
}

data "aws_ssm_parameter" "org_prefix" {
  name = "/omat/organization_prefix"
}

data "aws_ssm_parameter" "account_info" {
  name = "/omat/account_registry/${var.canonical_slug}"
}

locals {
  account_info = jsondecode(nonsensitive(data.aws_ssm_parameter.account_info.value))
  org_prefix   = nonsensitive(data.aws_ssm_parameter.org_prefix.value)
  param_prefix = local.account_info["prefix"]
}

data "aws_ssm_parameters_by_path" "roles" {
  path = "${local.param_prefix}/roles"
}

locals {
  roles = { for idx in range(length(data.aws_ssm_parameters_by_path.roles.names)) : reverse(split("/", data.aws_ssm_parameters_by_path.roles.names[idx]))[0] => nonsensitive(data.aws_ssm_parameters_by_path.roles.values[idx]) }
}
