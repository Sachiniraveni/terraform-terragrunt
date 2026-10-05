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

variable "map_public_ip_on_launch" {
    type = bool
    default = false
}

variable "public_subnet_tags" {
    type = map(string)
    default = {}
}

variable "private_subnet_tags" {
    type = map(string)
    default = {}
}