include "root"{
    path = find_in_parent_folders()
}

# EKS cluster runs in the public subnets of the dev VPC
dependency "vpc" {
    config_path = "../vpc"

    mock_outputs = {
        vpc_id = "temporary-dummy-id"
        public_subnets = ["subnet-dummy-a", "subnet-dummy-b"]
    }
    mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

terraform {
    source = "../../../modules//eks"
}

inputs = {

    aws_account_name = "nbf"
    environment_name = "dev"
    region = "us-east-1"
    kubernetes_version = "1.37"

    # Accessing outputs of other module dependency.module_name.outputs.output_name
    vpc_id = dependency.vpc.outputs.vpc_id
    subnet_ids = dependency.vpc.outputs.public_subnets

    endpoint_public_access = true

    eks_managed_node_groups = {
        default = {
            instance_types = ["t3.medium"]
            capacity_type = "ON_DEMAND"
            min_size = 1
            max_size = 3
            desired_size = 2
        }
    }

}
