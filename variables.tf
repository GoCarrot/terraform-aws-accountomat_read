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


variable "canonical_slug" {
  description = "The canonical_slug for the account as assigned by Accountomat. One of canonical_slug or account_id must be provided. If both are provided, canonical_slug will be preferred."
  type        = string
  default     = null
}

variable "account_id" {
  description = "The AWS assigned id for the account. One of canonical_slug or account_id must be provided. If both are provided, canonical_slug will be preferred."
  type        = string
  default     = null
}
