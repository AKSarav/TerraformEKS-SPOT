module "eks"{
  source = "terraform-aws-modules/eks/aws"
  version         = "<18"
  cluster_name = var.clustername
  cluster_version = "1.21"
  subnets = module.vpc.private_subnets
  enable_irsa = true
  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups_launch_template = [
    {
      name                    = "worker-group-spot-1"
      override_instance_types = var.spot_instance_types
      spot_allocation_strategy = "lowest-price"
      asg_max_size            = var.spot_max_size
      asg_desired_capacity    = var.spot_desired_size
      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot"
    },
  ]
  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = var.ondemand_instance_type
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = var.ondemand_desired_size
      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=ondemand"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}