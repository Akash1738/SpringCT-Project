provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = var.s3_bucket
    key            = "terraform/state.tfstate"
    region         = var.region
    dynamodb_table = var.dynamodb_table
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "project-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.15.1"

  cluster_name    = "nodejs-eks-cluster"
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  vpc_subnet_ids  = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      min_size       = 1
      max_size       = 2
      desired_size   = 2
      instance_types = ["t3.medium"]
    }
  }
}

resource "aws_ecr_repository" "nodejs_app" {
  name = "nodejs-app"
}
