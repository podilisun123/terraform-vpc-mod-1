# This  VPC Module is created by own and use this following resources
* create VPC
* create internet gate way and attached to VPC
* create 2 public subnets for 2 availability zones for HA
* create 2 private subnets for 2 availability zones for HA
* create 2 database subnets for 2 availability zones for HA
* create elastic IP for NAT Gateway
* create public route table
* create private route table
* create database route table
* create public,private and database routes to the public,private and database route table
* subnet association to the route tables
* if peering is reuired you can establish the peering connection

### Inputs
project_name(required): type is string and you should submit the value
environment(required): type is string and you should submit the value
common_tags(required): type is map and you should submit the value
vpc_cidr(optional): type is map and default value is 10.0.0.0/16

