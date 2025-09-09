output "natgw_id" {
  value = { for k, v in aws_nat_gateway.natgw : k => v.id }
}