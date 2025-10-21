resource "aws_vpc_peering_connection" "peering" {
  count = var.is_peering_need ? 1 : 0
  vpc_id        = aws_vpc.main.id
  peer_vpc_id   = var.acceptor_vpc == "" ? data.aws_vpc.default.id : var.acceptor_vpc
  auto_accept = var.acceptor_vpc == "" ? true : false
  tags = merge(
    var.common_tags,
    var.peering_tags,
    {
        Name = local.resource_name
    }
  )
}
    