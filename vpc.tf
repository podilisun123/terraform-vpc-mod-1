resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
      Name = local.resource_name
    }
  )
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
      Name = local.resource_name
    }
  )
}
### Public Subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  availability_zone = local.azs_value[count.index]
  cidr_block = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags =  merge(
    var.common_tags,
    var.public_subnet_tags,
    {
      Name = "${local.resource_name}-public-${local.azs_value[count.index]}"
    }
  )
}
### Private Subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  availability_zone = local.azs_value[count.index]
  cidr_block = var.private_subnet_cidrs[count.index]
  
  tags =  merge(
    var.common_tags,
    var.private_subnet_tags,
    {
      Name = "${local.resource_name}-private-${local.azs_value[count.index]}"
    }
  )
}
### Database Subnet
resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  availability_zone = local.azs_value[count.index]
  cidr_block = var.database_subnet_cidrs[count.index]
  
  tags =  merge(
    var.common_tags,
    var.database_subnet_tags,
    {
      Name = "${local.resource_name}-database-${local.azs_value[count.index]}"
    }
  )
}
### elastic ip
resource "aws_eip" "eip" {
  domain   = "vpc"
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id
  tags = merge(
    var.common_tags,
    var.nat_gateway_tags,
    {
      Name = "${local.resource_name}"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}
### Public Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.common_tags,
    var.public_route_table_tags,
    {
      Name = "${local.resource_name}-public"
    }
  )
}
### private Route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.common_tags,
    var.private_route_table_tags,
    {
      Name = "${local.resource_name}-private"
    }
  )
}
### database Route table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.common_tags,
    var.database_route_table_tags,
    {
      Name = "${local.resource_name}-database"
    }
  )
}
resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}
resource "aws_route" "private_route" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.ngw.id
}
resource "aws_route" "database_route" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.ngw.id
}
### subnet associates with routes
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public[*].id,count.index)
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private[*].id,count.index)
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id      = element(aws_subnet.database[*].id,count.index)
  route_table_id = aws_route_table.database.id
}