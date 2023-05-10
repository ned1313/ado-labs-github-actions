#############################################################################
# VARIABLES
#############################################################################

variable "location" {
  type    = string
  default = "westus"
}

variable "naming_prefix" {
  type    = string
  default = "voyagian"
}

variable "github_repository" {
  type    = string
  default = "ado-labs-github-actions"
}
