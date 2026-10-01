variable "cidr" {}
variable "aws_account_name" {}
variable "environment_name" {}
variable "enable_nat_gateway" {
    type = bool
}

variable "single_nat_gateway"{
    type = bool
}

variable "one_nat_gateway_per_az" {
    type = bool
}