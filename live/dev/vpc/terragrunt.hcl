include "root"{
    path = find_in_parent_folders()
}

terraform {
    source = "../../../modules//vpc"
}

inputs = {

    aws_account_name = "nbf"
    environment_name = "dev"
    region = "us-east-1"
    cidr = "10.0.0.0/16"
    single_nat_gateway = false
    one_nat_gateway_per_az = false
    enable_nat_gateway = false


}