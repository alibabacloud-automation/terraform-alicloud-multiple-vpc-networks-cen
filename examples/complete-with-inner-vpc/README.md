
# Complete


## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cen_instance_id"></a> [cen\_instance\_id](#output\_cen\_instance\_id) | The cen instance id. |
| <a name="output_cen_tr_id"></a> [cen\_tr\_id](#output\_cen\_tr\_id) | The cen transit router id. |
| <a name="output_dev_inner_tr_vpc_attachment_id"></a> [dev\_inner\_tr\_vpc\_attachment\_id](#output\_dev\_inner\_tr\_vpc\_attachment\_id) | The id of attachment between TR and dev inner VPC. |
| <a name="output_dev_inner_vpc_id"></a> [dev\_inner\_vpc\_id](#output\_dev\_inner\_vpc\_id) | The dev inner vpc id. |
| <a name="output_dev_inner_vswitch_ids"></a> [dev\_inner\_vswitch\_ids](#output\_dev\_inner\_vswitch\_ids) | The dev inner vswitch ids. |
| <a name="output_dev_tr_route_table_id"></a> [dev\_tr\_route\_table\_id](#output\_dev\_tr\_route\_table\_id) | The id of dev route table. |
| <a name="output_dev_tr_vpc_attachment_id"></a> [dev\_tr\_vpc\_attachment\_id](#output\_dev\_tr\_vpc\_attachment\_id) | The id of attachment between TR and VPC. |
| <a name="output_dev_vpc_id"></a> [dev\_vpc\_id](#output\_dev\_vpc\_id) | The dev vpc id. |
| <a name="output_dev_vswitch_ids"></a> [dev\_vswitch\_ids](#output\_dev\_vswitch\_ids) | The dev vswitch ids. |
| <a name="output_dmz_tr_route_table_id"></a> [dmz\_tr\_route\_table\_id](#output\_dmz\_tr\_route\_table\_id) | The id of dmz route table. |
| <a name="output_dmz_tr_vpc_attachment_id"></a> [dmz\_tr\_vpc\_attachment\_id](#output\_dmz\_tr\_vpc\_attachment\_id) | The id of attachment between TR and VPC. |
| <a name="output_dmz_vpc_id"></a> [dmz\_vpc\_id](#output\_dmz\_vpc\_id) | The dmz vpc id. |
| <a name="output_dmz_vswitch_ids"></a> [dmz\_vswitch\_ids](#output\_dmz\_vswitch\_ids) | The dmz vswitch ids. |
| <a name="output_prod_inner_tr_vpc_attachment_id"></a> [prod\_inner\_tr\_vpc\_attachment\_id](#output\_prod\_inner\_tr\_vpc\_attachment\_id) | The id of attachment between TR and prod inner VPC. |
| <a name="output_prod_inner_vpc_id"></a> [prod\_inner\_vpc\_id](#output\_prod\_inner\_vpc\_id) | The prod inner vpc id. |
| <a name="output_prod_inner_vswitch_ids"></a> [prod\_inner\_vswitch\_ids](#output\_prod\_inner\_vswitch\_ids) | The prod inner vswitch ids. |
| <a name="output_prod_tr_route_table_id"></a> [prod\_tr\_route\_table\_id](#output\_prod\_tr\_route\_table\_id) | The id of prod route table. |
| <a name="output_prod_tr_vpc_attachment_id"></a> [prod\_tr\_vpc\_attachment\_id](#output\_prod\_tr\_vpc\_attachment\_id) | The id of attachment between TR and VPC. |
| <a name="output_prod_vpc_id"></a> [prod\_vpc\_id](#output\_prod\_vpc\_id) | The prod vpc id. |
| <a name="output_prod_vswitch_ids"></a> [prod\_vswitch\_ids](#output\_prod\_vswitch\_ids) | The prod vswitch ids. |
<!-- END_TF_DOCS -->