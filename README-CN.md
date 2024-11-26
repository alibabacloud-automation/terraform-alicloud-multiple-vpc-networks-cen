Terraform module to build multi-VPC Network(Complex Network Interconnection Scenario - Single-Plane Networking) for Alibaba Cloud

terraform-alicloud-multiple-vpc-networks-cen
======================================

[English](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-cen/blob/main/README.md) | 简体中文

本卓越架构设计重点介绍本在阿里云环境中，如何使用VPC对等连接和转发路由器，针对不同的客户场景和需求，构建高效、安全且高可用的同区域多VPC网络架构，提供一套Well-Architected解决方案。  
复杂网络互联场景-单平面组网中，企业多个业务VPC之间通过TR进行大规模组网，实现VPC之间的按需互通。同时构建DMZ VPC以统一管理所有公网出入流量。生产、开发、DMZ区按照TR路由表划分成多平面，各个业务模块的VPC绑定独立的TR路由表，TR路由表中的路由配置和路由策略决定之间的互通。同时可以构建公网路由表，仅用于管理DMZ VPC的路由转发，作为各个生产、开发环境南北向流量管理的统一出入口。  
流程简介如下：
1. 划分生成、测试、DMZ区不同环境
2. 在每个环境内创建多个VPC及对应VSW
3. 创建CEN和TR
4. 通过TR-attachment把VPC加入CEN中
5. 为不同环境分别创建个TR路由表
6. 在每个路由表内创建对应路由条目，实现路由的隔离和打通
7. 将TR路由表和VPC-attachment创建关联 


架构图:

![Diagram](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-cen/main/scripts/diagram.png)


## 用法

创建一个 DMZ 区的 VPC，测试环境的一个 VPC 以及生产环境的两个 VPC


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



## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-cen/tree/main/examples/complete)
* [创建内部VPC的完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-multiple-vpc-networks-cen/tree/main/examples/complete-with-inner-vpc)


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

## 提交问题

如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

## 作者

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## 许可

MIT Licensed. See LICENSE for full details.

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
