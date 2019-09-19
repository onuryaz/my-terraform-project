variable "region" {

  default = "eu-west-1"

}

variable "environment" {
  
}



variable "public_subnet_1_cidr" {

  description = "CIDR Block for Public Subnet 1"

}

variable "public_subnet_2_cidr" {

  description = "CIDR Block for Public Subnet 2"

}

variable "public_subnet_3_cidr" {

  description = "CIDR Block for Public Subnet 3"

}


variable "private_subnet_1_cidr" {

  description = "CIDR Block for Private Subnet 1"

}

variable "private_subnet_2_cidr" {

  description = "CIDR Block for Private Subnet 2"

}

variable "private_subnet_3_cidr" {

  description = "CIDR Block for Private Subnet 3"

}


# If the average CPU utilization over a minute drops to this threshold,
# the number of containers will be reduced (but not below ecs_autoscale_min_instances).
variable "ecs_as_cpu_low_threshold_per" {
  default = "20"
}

# If the average CPU utilization over a minute rises to this threshold,
# the number of containers will be increased (but not above ecs_autoscale_max_instances).
variable "ecs_as_cpu_high_threshold_per" {
  default = "80"
}


variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}


variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}


variable "app_image" {

}

variable "app_count" {
  default = 1
}
