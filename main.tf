module "vpc" {
  source     = "./modules/vpc"
  stack_name = var.stack_name
  region     = var.region
}

module "iam" {
  source     = "./modules/iam"
  stack_name = var.stack_name
}

module "security_groups" {
  source     = "./modules/security-groups"
  stack_name = var.stack_name
  vpc_id     = module.vpc.vpc_id
}

module "eks_cluster" {
  source              = "./modules/eks-cluster"
  stack_name          = var.stack_name
  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  public_subnet_ids   = module.vpc.public_subnet_ids
  eks_service_role_arn = module.iam.eks_service_role_arn
  control_plane_sg_id = module.security_groups.control_plane_sg_id
}
