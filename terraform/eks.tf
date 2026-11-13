module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "~> 20.11"

    cluster_name = "prod-ecommerce-eks"
    cluster_version = "1.31"

    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
    cluster_endpoint_public_access = true

    #Grant your IAM user (jayakanth-devops) full admin access to the cluster_endpoint_public_access
    enable_cluster_creator_admin_permissions = true

    eks_managed_node_groups = {
        general = {
            ami_type = "AL2023_x86_64_STANDARD" # Amazon EKS optimized AMI for Kubernetes 1.32
            min_size = 1
            max_size = 3
            desired_size = 2
            instance_types = ["t3.micro"]
            capacity_type = "ON_DEMAND"
        }
    }
}

output "cluster_name" {
    value = module.eks.cluster_name
}

output "configure_kubectl" {
    value = "aws eks update-kubeconfig --region ap-south-1 --name ${module.eks.cluster_name}"
}
