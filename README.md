Terraform module to build multi-VPC Network(Complex Network Interconnection Scenario - Single-Plane Networking) for Alibaba Cloud

terraform-alicloud-multiple-vpc-networks-cen
======================================

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-cen/blob/main/README-CN.md)

This Well-Architecture design emphasizes how to use VPC peering or transit routers in the Alibaba Cloud  to build an efficient, secure, and highly available multi-VPC network architecture within the same region, tailored to different customer scenarios and needs.  
In the complex network interconnection scenario with a single-plane network, multiple business VPCs within an enterprise can achieve large-scale interconnection through Transit Router (TR) to enable on-demand communication between VPCs. Additionally, a DMZ VPC is constructed to centrally manage all public traffic ingress and egress. The production, development, and DMZ zones are divided into multiple planes according to the TR routing tables. Each business module's VPC is bound to an independent TR routing table, where the routing configuration and policy in the TR routing table determine inter-VPC communication. Furthermore, a public routing table can be constructed solely for managing the routing and forwarding of the DMZ VPC, serving as the unified entry and exit point for north-south traffic management in various production and development environments.  
The process overview is as follows:
1. Divide distinct environments for production, testing, and DMZ areas.
2. Create multiple VPCs and corresponding Virtual Switches (VSW) within each environment.
3. Create a Cloud Enterprise Network (CEN) and a Transit Router (TR).
4. Add VPCs to the CEN using TR-attachment.
5. Create separate TR routing tables for different environments.
6. Establish corresponding routing entries within each routing table to achieve routing isolation and connectivity.
7. Associate the TR routing tables with their respective VPC-attachments.


Architecture Diagram:

![Diagram](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-cen/main/scripts/diagram.png)


## Usage

create one VPC in DMZ, one VPC in Dev and two VPCs in Prod.

```hcl
provider "alicloud" {
  region = "cn-hangzhou"
}

module "complete" {
  source = "alibabacloud-automation/multiple-vpc-networks-cen/alicloud"

  vpcs = {
    dmz = {
      cidr_block = "10.1.0.0/16"
      vswitches = [
        {
          subnet  = "10.1.0.0/24"
          zone_id = "cn-hangzhou-h"
          }, {
          subnet  = "10.1.1.0/24"
          zone_id = "cn-hangzhou-i"
          }, {
          subnet  = "10.1.2.0/24"
          zone_id = "cn-hangzhou-j"
        }
      ]
    }
    prod = [{
      cidr_block = "10.2.0.0/16"
      vswitches = [
        {
          subnet  = "10.2.0.0/24"
          zone_id = "cn-hangzhou-h"
          }, {
          subnet  = "10.2.1.0/24"
          zone_id = "cn-hangzhou-i"
          }, {
          subnet  = "10.2.2.0/24"
          zone_id = "cn-hangzhou-j"
        }
      ]
      }, {
      cidr_block = "10.3.0.0/16"
      vswitches = [
        {
          subnet  = "10.3.0.0/24"
          zone_id = "cn-hangzhou-h"
          }, {
          subnet  = "10.3.1.0/24"
          zone_id = "cn-hangzhou-i"
          }, {
          subnet  = "10.3.2.0/24"
          zone_id = "cn-hangzhou-j"
        }
      ]
    }]
    dev = [{
      cidr_block = "10.4.0.0/16"
      vswitches = [
        {
          subnet  = "10.4.0.0/24"
          zone_id = "cn-hangzhou-h"
          }, {
          subnet  = "10.4.1.0/24"
          zone_id = "cn-hangzhou-i"
          }, {
          subnet  = "10.4.2.0/24"
          zone_id = "cn-hangzhou-j"
        }
      ]
    }]
  }

  tags = {
    "Createdby" = "terraform"
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-cen/tree/main/examples/complete)
* [Complete With Inner VPC Example](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-cen/tree/main/examples/complete-with-inner-vpc)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dev"></a> [dev](#module\_dev) | ./modules/vpc | n/a |
| <a name="module_dev_inner"></a> [dev\_inner](#module\_dev\_inner) | ./modules/vpc | n/a |
| <a name="module_dmz"></a> [dmz](#module\_dmz) | ./modules/vpc | n/a |
| <a name="module_prod"></a> [prod](#module\_prod) | ./modules/vpc | n/a |
| <a name="module_prod_inner"></a> [prod\_inner](#module\_prod\_inner) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_cen_instance.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_instance) | resource |
| [alicloud_cen_transit_router.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router) | resource |
| [alicloud_cen_transit_router_route_entry.dev_block_prod](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.dev_to_dmz](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.dev_vpc_all](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.dmz_to_dev](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.dmz_to_prod](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.prod_block_dev](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.prod_to_dmz](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_entry.prod_vpc_all](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_entry) | resource |
| [alicloud_cen_transit_router_route_table.dev](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table.dmz](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table.prod](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table) | resource |
| [alicloud_cen_transit_router_route_table_association.dev_all](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.dmz](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_cen_transit_router_route_table_association.prod](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/cen_transit_router_route_table_association) | resource |
| [alicloud_regions.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cen_instance_name"></a> [cen\_instance\_name](#input\_cen\_instance\_name) | The name of cen instance. | `string` | `"Single_Plane_DMZ_CEN"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The ID of the resource group. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags of the resource. | `any` | `null` | no |
| <a name="input_transit_router_name"></a> [transit\_router\_name](#input\_transit\_router\_name) | The name of cen transit router. | `string` | `"transit_router_DMZ"` | no |
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | The parameters of VPCs. | <pre>object({<br>    dmz = object({<br>      cidr_block = string<br>      vswitches = list(object({<br>        subnet  = string<br>        zone_id = string<br>      }))<br>    })<br>    prod = list(object({<br>      cidr_block = string<br>      vswitches = list(object({<br>        subnet  = string<br>        zone_id = string<br>      }))<br>    }))<br>    dev = list(object({<br>      cidr_block = string<br>      vswitches = list(object({<br>        subnet  = string<br>        zone_id = string<br>      }))<br>    }))<br>    prod_inner = optional(list(object({<br>      cidr_block = string<br>      vswitches = list(object({<br>        subnet  = string<br>        zone_id = string<br>      }))<br>    })), [])<br>    dev_inner = optional(list(object({<br>      cidr_block = string<br>      vswitches = list(object({<br>        subnet  = string<br>        zone_id = string<br>      }))<br>    })), [])<br>  })</pre> | <pre>{<br>  "dev": [],<br>  "dmz": {<br>    "cidr_block": null,<br>    "vswitches": []<br>  },<br>  "prod": []<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cen_instance_id"></a> [cen\_instance\_id](#output\_cen\_instance\_id) | The cen instance id. |
| <a name="output_cen_tr_id"></a> [cen\_tr\_id](#output\_cen\_tr\_id) | The cen transit router id. |
| <a name="output_dev_inner_tr_vpc_attachment_id"></a> [dev\_inner\_tr\_vpc\_attachment\_id](#output\_dev\_inner\_tr\_vpc\_attachment\_id) | The id of attachment between TR and dev inner VPC. |
| <a name="output_dev_inner_vpc_id"></a> [dev\_inner\_vpc\_id](#output\_dev\_inner\_vpc\_id) | The dev inner vpc id. |
| <a name="output_dev_inner_vswitch_ids"></a> [dev\_inner\_vswitch\_ids](#output\_dev\_inner\_vswitch\_ids) | The dev inner vswitch ids. |
| <a name="output_dev_tr_route_table_id"></a> [dev\_tr\_route\_table\_id](#output\_dev\_tr\_route\_table\_id) | The id of dev route table. |
| <a name="output_dev_tr_vpc_attachment_id"></a> [dev\_tr\_vpc\_attachment\_id](#output\_dev\_tr\_vpc\_attachment\_id) | The id of attachment between TR and dev VPC. |
| <a name="output_dev_vpc_id"></a> [dev\_vpc\_id](#output\_dev\_vpc\_id) | The dev vpc id. |
| <a name="output_dev_vswitch_ids"></a> [dev\_vswitch\_ids](#output\_dev\_vswitch\_ids) | The dev vswitch ids. |
| <a name="output_dmz_tr_route_table_id"></a> [dmz\_tr\_route\_table\_id](#output\_dmz\_tr\_route\_table\_id) | The id of dmz route table. |
| <a name="output_dmz_tr_vpc_attachment_id"></a> [dmz\_tr\_vpc\_attachment\_id](#output\_dmz\_tr\_vpc\_attachment\_id) | The id of attachment between TR and dmz VPC. |
| <a name="output_dmz_vpc_id"></a> [dmz\_vpc\_id](#output\_dmz\_vpc\_id) | The dmz vpc id. |
| <a name="output_dmz_vswitch_ids"></a> [dmz\_vswitch\_ids](#output\_dmz\_vswitch\_ids) | The dmz vswitch ids. |
| <a name="output_prod_inner_tr_vpc_attachment_id"></a> [prod\_inner\_tr\_vpc\_attachment\_id](#output\_prod\_inner\_tr\_vpc\_attachment\_id) | The id of attachment between TR and prod inner VPC. |
| <a name="output_prod_inner_vpc_id"></a> [prod\_inner\_vpc\_id](#output\_prod\_inner\_vpc\_id) | The prod inner vpc id. |
| <a name="output_prod_inner_vswitch_ids"></a> [prod\_inner\_vswitch\_ids](#output\_prod\_inner\_vswitch\_ids) | The prod inner vswitch ids. |
| <a name="output_prod_tr_route_table_id"></a> [prod\_tr\_route\_table\_id](#output\_prod\_tr\_route\_table\_id) | The id of prod route table. |
| <a name="output_prod_tr_vpc_attachment_id"></a> [prod\_tr\_vpc\_attachment\_id](#output\_prod\_tr\_vpc\_attachment\_id) | The id of attachment between TR and prod VPC. |
| <a name="output_prod_vpc_id"></a> [prod\_vpc\_id](#output\_prod\_vpc\_id) | The prod vpc id. |
| <a name="output_prod_vswitch_ids"></a> [prod\_vswitch\_ids](#output\_prod\_vswitch\_ids) | The prod vswitch ids. |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
