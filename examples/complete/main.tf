provider "alicloud" {
  region = "cn-hangzhou"
}

module "complete" {
  source = "../.."

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

