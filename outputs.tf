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

output "id" {
  description = "AWS account id"
  value       = local.account_info["account_id"]
}

output "environment" {
  description = <<-EOT
  This should correspond to a phase in your software development lifecycle,
  e.g. development, production, stage, etc. Environment is used by other
  *omat services with attributed based access control to restrict mixing of
  SDLC stages.
EOT

  value = local.account_info["orig_environment"]
}

output "name" {
  description = <<-EOT
  The human readable name of the account. This should be unique across your
  organization, but this is not enforced. Will who up in billing reports.
EOT

  value = local.account_info["name"]
}

output "purpose" {
  description = <<-EOT
  What is this account for? This should be high level,
  e.g. workload, CI/CD, sandbox, etc.
EOT

  value = local.account_info["purpose"]
}

output "param_prefix" {
  description = "The prefix under which SSM parameters for this account are stored."
  value       = local.account_info["prefix"]
}

output "roles" {
  description = <<-EOT
  Map of role name/type to role arn, e.g. roles["admin"] => ARN for role to
  administer the account.
EOT
  value       = local.roles
}

output "account_info" {
  description = <<-EOT
  All account information as stored by accountomat.
EOT

  value = local.account_info
}
