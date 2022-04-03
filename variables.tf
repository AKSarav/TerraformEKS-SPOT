variable "clustername"{
    default = "GritfyEKS"
    description = "Gritfy  EKS Cluster"
}
variable "spot_instance_types"{
    default = ["t3.small","t2.small"]
    description = "List of instance types for SPOT instance selection"
}
variable "ondemand_instance_type"{
    default = "t3.medium"
    description = "On Demand instance type"
}
variable "spot_max_size"{
    default = 2
    description = "How many SPOT instance can be created max"
}
variable "spot_desired_size"{
    default = 2
    description = "How many SPOT instance should be running at all times"
}
variable "ondemand_desired_size"{
    default = 2
    description = "How many OnDemand instances should be running at all times"
}
