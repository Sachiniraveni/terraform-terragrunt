# Ref https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
# Cluster and nodes run in the subnets passed in from modules/vpc.
# For public subnets, the subnets must assign public IPs (map_public_ip_on_launch).
module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "21.26.0"

    name = "${var.aws_account_name}-${var.environment_name}-eks"
    kubernetes_version = var.kubernetes_version

    vpc_id = var.vpc_id
    subnet_ids = var.subnet_ids

    endpoint_public_access = var.endpoint_public_access
    endpoint_public_access_cidrs = var.endpoint_public_access_cidrs


    # Cluster access is managed with EKS access entries (no aws-auth configmap).
    # The IAM identity running apply becomes cluster admin.
    enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
    access_entries = var.access_entries


    # vpc-cni and pod identity agent must be in place before nodes join
    addons = {
        vpc-cni = {
            before_compute = true
        }
        eks-pod-identity-agent = {
            before_compute = true
        }
        kube-proxy = {}
        coredns = {}
    }

    eks_managed_node_groups = var.eks_managed_node_groups

tags ={
    Terraform = true
    project = var.aws_account_name
    Environment = var.environment_name
}

}
