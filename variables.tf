### project variable
variable "project_name" {
    type = string
}
variable "environment" {
    type = string
}
variable "common_tags" {
  type = map
}
### vpc variable

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}
variable "enable_dns_hostnames" {
  type = bool
  default = true
}
variable "vpc_tags" {
  type = map
  default = {}
}

### internet gateway variables
variable "igw_tags" {
  type = map
  default = {}
}

### Public Subnet variables
variable "public_subnet_cidrs" {
  type = list
  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Plese give 2 valid public subnet cidrs"
  }
  
}
variable "public_subnet_tags" {
  type = map
  default = {}
}
### Private Subnet variables
variable "private_subnet_cidrs" {
  type = list
  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Plese give 2 valid private subnet cidrs"
  }
  
}
variable "private_subnet_tags" {
  type = map
  default = {}
}
### database Subnet variables
variable "database_subnet_cidrs" {
  type = list
  validation {
    condition     = length(var.database_subnet_cidrs) == 2
    error_message = "Plese give 2 valid database subnet cidrs"
  }
  
}
### database subnet group variables
variable "database_subnet_group_tags" {
  type = map
  default = {}
}
variable "database_subnet_tags" {
  type = map
  default = {}
}

### nat gate way
variable "nat_gateway_tags" {
  type = map
  default = {}
}
### public route table
variable "public_route_table_tags" {
  type = map
  default = {}
}
### private route table
variable "private_route_table_tags" {
  type = map
  default = {}
}
### database route table
variable "database_route_table_tags" {
  type = map
  default = {}
}
### peering variable
variable "is_peering_need" {
  type = bool
  default = false
}
variable "acceptor_vpc" {
  type = string
  default = ""
}
variable "peering_tags" {
  type = map
  default = {}
}




