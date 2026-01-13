output "dns_zone_name" {
  description = "The name of the created DNS zone"
  value       = aws_route53_zone.public_zone.name
}

output "dns_zone_id" {
  description = "The ID of the DNS zone"
  value       = aws_route53_zone.public_zone.zone_id
}

output "private_dns_zone_name" {
  description = "The name of the created private DNS zone"
  value       = aws_route53_zone.private_zone.name
}

output "private_dns_zone_id" {
  description = "The ID of the created private DNS zone"
  value       = aws_route53_zone.private_zone.zone_id
}

output "name_servers" {
  description = "The list of name servers for the DNS zone"
  value       = aws_route53_zone.public_zone.name_servers
}
