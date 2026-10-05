data "aws_availability_zones" "name" {
 state = "available" 
}

module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "6.7.3"
    name = "${var.aws_account_name}-${var.environment_name}-vpc"
    cidr = var.cidr
    azs = data.aws_availability_zones.name.names
    private_subnets = [cidrsubnet(var.cidr, 8, 0), cidrsubnet(var.cidr, 8, 1)]
    public_subnets = [cidrsubnet(var.cidr, 8, 2 ), cidrsubnet(var.cidr, 8, 3)]


    private_subnet_suffix = "private"
    public_subnet_suffix = "public"

    # Extra subnet tags, e.g. for EKS load balancer subnet discovery
    public_subnet_tags = var.public_subnet_tags
    private_subnet_tags = var.private_subnet_tags


    # Instances in public subnets get a public IP (required for EKS nodes in public subnets)
    map_public_ip_on_launch = var.map_public_ip_on_launch


    #RDS public subnet
    create_database_subnet_group = true
    create_database_subnet_route_table = true
    create_database_internet_gateway_route = true


    #flow_log
    create_flow_log_cloudwatch_iam_role = true
    create_flow_log_cloudwatch_log_group = true
    enable_flow_log = true
    flow_log_cloudwatch_log_group_name_prefix ="/aws/${var.environment_name}-vpc-flow-log/"
    flow_log_file_format = "parquet"


    #VPN
    
  enable_dns_hostnames = true
  enable_dns_support   = true
  create_igw           = true

tags ={
    Terraform = true
    project = var.aws_account_name
    Environment = var.environment_name
}

}