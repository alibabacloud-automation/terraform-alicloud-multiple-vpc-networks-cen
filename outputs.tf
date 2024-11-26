# CEN
output "cen_instance_id" {
  value       = alicloud_cen_instance.default.id
  description = "The cen instance id."
}

output "cen_tr_id" {
  value       = alicloud_cen_transit_router.default.id
  description = "The cen transit router id."
}

# DMZ
output "dmz_vpc_id" {
  value       = module.dmz.vpc_id
  description = "The dmz vpc id."
}

output "dmz_vswitch_ids" {
  value       = module.dmz.vswitch_ids
  description = "The dmz vswitch ids."
}

output "dmz_tr_vpc_attachment_id" {
  value       = module.dmz.tr_vpc_attachment_id
  description = "The id of attachment between TR and dmz VPC."
}

output "dmz_tr_route_table_id" {
  value       = alicloud_cen_transit_router_route_table.dmz.transit_router_route_table_id
  description = "The id of dmz route table."
}


# Prod
output "prod_vpc_id" {
  value       = module.prod[*].vpc_id
  description = "The prod vpc id."
}

output "prod_vswitch_ids" {
  value       = module.prod[*].vswitch_ids
  description = "The prod vswitch ids."
}

output "prod_tr_vpc_attachment_id" {
  value       = module.prod[*].tr_vpc_attachment_id
  description = "The id of attachment between TR and prod VPC."
}

output "prod_tr_route_table_id" {
  value       = alicloud_cen_transit_router_route_table.prod.transit_router_route_table_id
  description = "The id of prod route table."
}

output "prod_inner_vpc_id" {
  value       = module.prod_inner[*].vpc_id
  description = "The prod inner vpc id."
}

output "prod_inner_vswitch_ids" {
  value       = module.prod_inner[*].vswitch_ids
  description = "The prod inner vswitch ids."
}

output "prod_inner_tr_vpc_attachment_id" {
  value       = module.prod_inner[*].tr_vpc_attachment_id
  description = "The id of attachment between TR and prod inner VPC."
}

# Dev
output "dev_vpc_id" {
  value       = module.dev[*].vpc_id
  description = "The dev vpc id."
}

output "dev_vswitch_ids" {
  value       = module.dev[*].vswitch_ids
  description = "The dev vswitch ids."
}

output "dev_tr_vpc_attachment_id" {
  value       = module.dev[*].tr_vpc_attachment_id
  description = "The id of attachment between TR and dev VPC."
}

output "dev_tr_route_table_id" {
  value       = alicloud_cen_transit_router_route_table.dev.transit_router_route_table_id
  description = "The id of dev route table."
}

output "dev_inner_vpc_id" {
  value       = module.dev_inner[*].vpc_id
  description = "The dev inner vpc id."
}

output "dev_inner_vswitch_ids" {
  value       = module.dev_inner[*].vswitch_ids
  description = "The dev inner vswitch ids."
}

output "dev_inner_tr_vpc_attachment_id" {
  value       = module.dev_inner[*].tr_vpc_attachment_id
  description = "The id of attachment between TR and dev inner VPC."
}