output "cen_instance_id" {
  value       = module.complete.cen_instance_id
  description = "The cen instance id."
}

output "cen_tr_id" {
  value       = module.complete.cen_tr_id
  description = "The cen transit router id."
}

# DMZ
output "dmz_vpc_id" {
  value       = module.complete.dmz_vpc_id
  description = "The dmz vpc id."
}

output "dmz_vswitch_ids" {
  value       = module.complete.dmz_vswitch_ids
  description = "The dmz vswitch ids."
}

output "dmz_tr_vpc_attachment_id" {
  value       = module.complete.dmz_tr_vpc_attachment_id
  description = "The id of attachment between TR and VPC."
}

output "dmz_tr_route_table_id" {
  value       = module.complete.dmz_tr_route_table_id
  description = "The id of dmz route table."
}


# Prod
output "prod_vpc_id" {
  value       = module.complete.prod_vpc_id
  description = "The prod vpc id."
}

output "prod_vswitch_ids" {
  value       = module.complete.prod_vswitch_ids
  description = "The prod vswitch ids."
}

output "prod_tr_vpc_attachment_id" {
  value       = module.complete.prod_tr_vpc_attachment_id
  description = "The id of attachment between TR and VPC."
}

output "prod_tr_route_table_id" {
  value       = module.complete.prod_tr_route_table_id
  description = "The id of prod route table."
}

# Dev
output "dev_vpc_id" {
  value       = module.complete.dev_vpc_id
  description = "The dev vpc id."
}

output "dev_vswitch_ids" {
  value       = module.complete.dev_vswitch_ids
  description = "The dev vswitch ids."
}

output "dev_tr_vpc_attachment_id" {
  value       = module.complete.dev_tr_vpc_attachment_id
  description = "The id of attachment between TR and VPC."
}

output "dev_tr_route_table_id" {
  value       = module.complete.dev_tr_route_table_id
  description = "The id of dev route table."
}

