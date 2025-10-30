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
enable_dns_hostnames(optional): type is boolean and default value is true
vpc_tags(optional): type is map and default value is empty
igw_tags(optional): type is map and default value is empty
public_subnet_cidrs(required): type is list and you should submit the 2 valid public subnet cidrs
private_subnet_cidrs(required): type is list and you should submit the 2 valid private subnet cidrs
database_subnet_cidrs(required): type is list and you should submit the 2 valid database subnet cidrs
public_subnet_tags(optional): type is map and default value is empty
private_subnet_tags(optional): type is map and default value is empty
database_subnet_tags(optional): type is map and default value is empty
database_subnet_group_tags(optional): type is map and default value is empty
nat_gateway_tags(optional): type is map and default value is empty
public_route_table_tags(optional): type is map and default value is empty
private_route_table_tags(optional): type is map and default value is empty
database_route_table_tags(optional): type is map and default value is empty
is_peering_need(optional): type is boolean and default value is false
acceptor_vpc(optional): type is string and default value is empty
peering_tags(optional): type is map and default value is empty