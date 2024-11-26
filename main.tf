data "alicloud_regions" "default" {
  current = true
}
/*
 * CEN
 */
resource "alicloud_cen_instance" "default" {
  cen_instance_name = var.cen_instance_name
  resource_group_id = var.resource_group_id
  tags              = var.tags
}

resource "alicloud_cen_transit_router" "default" {
  transit_router_name = "${var.transit_router_name}_${data.alicloud_regions.default.regions[0].id}"
  cen_id              = alicloud_cen_instance.default.id
  tags                = var.tags
}


/*
 * VPC, VSwitch and Attachment
 */
module "dmz" {
  source = "./modules/vpc"

  cen_instance_id       = alicloud_cen_instance.default.id
  cen_transit_router_id = alicloud_cen_transit_router.default.transit_router_id

  vpc = {
    vpc_name   = "DMZ_VPC"
    cidr_block = var.vpcs.dmz.cidr_block
    vswitches  = var.vpcs.dmz.vswitches
  }
  tr_vpc_attachment_name = "DMZ_VPC_Attachment"

  resource_group_id = var.resource_group_id
  tags              = var.tags
}

module "prod" {
  source = "./modules/vpc"
  count  = length(var.vpcs.prod)

  cen_instance_id       = alicloud_cen_instance.default.id
  cen_transit_router_id = alicloud_cen_transit_router.default.transit_router_id

  vpc = {
    vpc_name   = "Prod_VPC${count.index + 1}"
    cidr_block = var.vpcs.prod[count.index].cidr_block
    vswitches  = var.vpcs.prod[count.index].vswitches
  }
  tr_vpc_attachment_name = "Prod_VPC${count.index + 1}_Attachment"

  resource_group_id = var.resource_group_id
  tags              = var.tags
}

module "dev" {
  source = "./modules/vpc"
  count  = length(var.vpcs.dev)

  cen_instance_id       = alicloud_cen_instance.default.id
  cen_transit_router_id = alicloud_cen_transit_router.default.transit_router_id

  vpc = {
    vpc_name   = "Dev_VPC${count.index + 1}"
    cidr_block = var.vpcs.dev[count.index].cidr_block
    vswitches  = var.vpcs.dev[count.index].vswitches
  }
  tr_vpc_attachment_name = "Dev_VPC${count.index + 1}_Attachment"

  resource_group_id = var.resource_group_id
  tags              = var.tags
}


module "prod_inner" {
  source = "./modules/vpc"
  count  = length(var.vpcs.prod_inner)

  cen_instance_id       = alicloud_cen_instance.default.id
  cen_transit_router_id = alicloud_cen_transit_router.default.transit_router_id

  vpc = {
    vpc_name   = "Prod_Inner_VPC${count.index + 1}"
    cidr_block = var.vpcs.prod_inner[count.index].cidr_block
    vswitches  = var.vpcs.prod_inner[count.index].vswitches
  }
  tr_vpc_attachment_name = "Prod_Inner_VPC${count.index + 1}_Attachment"

  resource_group_id = var.resource_group_id
  tags              = var.tags
}

module "dev_inner" {
  source = "./modules/vpc"
  count  = length(var.vpcs.dev_inner)

  cen_instance_id       = alicloud_cen_instance.default.id
  cen_transit_router_id = alicloud_cen_transit_router.default.transit_router_id

  vpc = {
    vpc_name   = "Dev_Inner_VPC${count.index + 1}"
    cidr_block = var.vpcs.dev_inner[count.index].cidr_block
    vswitches  = var.vpcs.dev_inner[count.index].vswitches
  }
  tr_vpc_attachment_name = "Dev_Inner_VPC${count.index + 1}_Attachment"

  resource_group_id = var.resource_group_id
  tags              = var.tags
}



/*
 * Route Table
 */

resource "alicloud_cen_transit_router_route_table" "dmz" {
  transit_router_id               = alicloud_cen_transit_router.default.transit_router_id
  transit_router_route_table_name = "dmz-route-table"
  tags                            = var.tags
}

resource "alicloud_cen_transit_router_route_table" "prod" {
  transit_router_id               = alicloud_cen_transit_router.default.transit_router_id
  transit_router_route_table_name = "prod-route-table"
  tags                            = var.tags
}

resource "alicloud_cen_transit_router_route_table" "dev" {
  transit_router_id               = alicloud_cen_transit_router.default.transit_router_id
  transit_router_route_table_name = "dev-route-table"
  tags                            = var.tags
}


/*
 * route entry between dmz, prod and dev
 */

# dmz
resource "alicloud_cen_transit_router_route_entry" "dmz_to_prod" {
  count = length(module.prod)

  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.dmz.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = module.prod[count.index].vpc_cidr_block
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = module.prod[count.index].tr_vpc_attachment_id
}

resource "alicloud_cen_transit_router_route_entry" "dmz_to_dev" {
  count = length(module.dev)

  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.dmz.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = module.dev[count.index].vpc_cidr_block
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = module.dev[count.index].tr_vpc_attachment_id
}

# prod
resource "alicloud_cen_transit_router_route_entry" "prod_to_dmz" {
  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.prod.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = "0.0.0.0/0"
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = module.dmz.tr_vpc_attachment_id
}

resource "alicloud_cen_transit_router_route_entry" "prod_block_dev" {
  for_each = { for i, v in concat(module.dev, module.dev_inner) : i => v }

  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.prod.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = each.value.vpc_cidr_block
  transit_router_route_entry_next_hop_type          = "BlackHole"
}


resource "alicloud_cen_transit_router_route_entry" "prod_vpc_all" {
  for_each = { for i, v in concat(module.prod, module.prod_inner) : i => v }

  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.prod.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = each.value.vpc_cidr_block
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = each.value.tr_vpc_attachment_id
}

# dev
resource "alicloud_cen_transit_router_route_entry" "dev_to_dmz" {
  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.dev.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = "0.0.0.0/0"
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = module.dmz.tr_vpc_attachment_id
}

resource "alicloud_cen_transit_router_route_entry" "dev_block_prod" {
  for_each = { for i, v in concat(module.prod, module.prod_inner) : i => v }

  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.dev.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = each.value.vpc_cidr_block
  transit_router_route_entry_next_hop_type          = "BlackHole"
}

resource "alicloud_cen_transit_router_route_entry" "dev_vpc_all" {
  for_each = { for i, v in concat(module.dev, module.dev_inner) : i => v }

  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.dev.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = each.value.vpc_cidr_block
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = each.value.tr_vpc_attachment_id
}

# cen_tr_table_association
resource "alicloud_cen_transit_router_route_table_association" "dmz" {
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.dmz.transit_router_route_table_id
  transit_router_attachment_id  = module.dmz.tr_vpc_attachment_id
}
resource "alicloud_cen_transit_router_route_table_association" "prod" {
  for_each = { for i, v in concat(module.prod, module.prod_inner) : i => v }

  transit_router_route_table_id = alicloud_cen_transit_router_route_table.prod.transit_router_route_table_id
  transit_router_attachment_id  = each.value.tr_vpc_attachment_id
}
resource "alicloud_cen_transit_router_route_table_association" "dev_all" {
  for_each = { for i, v in concat(module.dev, module.dev_inner) : i => v }

  transit_router_route_table_id = alicloud_cen_transit_router_route_table.dev.transit_router_route_table_id
  transit_router_attachment_id  = each.value.tr_vpc_attachment_id
}
