variable "aws_account_name" {}
variable "environment_name" {}

variable "kubernetes_version" {
    type = string
}

# From the vpc module
variable "vpc_id" {
    type = string
}

variable "subnet_ids" {
    type = list(string)
}

variable "endpoint_public_access" {
    type = bool
    default = true
}

variable "endpoint_public_access_cidrs" {
    type = list(string)
    default = ["0.0.0.0/0"]
}

variable "enable_cluster_creator_admin_permissions" {
    type = bool
    default = true
}

# Extra IAM principals that get cluster access
# Ref https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest#input_access_entries
variable "access_entries" {
    type = any
    default = {}
}

# Ref https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest#input_eks_managed_node_groups
variable "eks_managed_node_groups" {
    type = any
}
