variable "cen_instance_name" {
  type        = string
  description = "The name of cen instance."
  default     = "Single_Plane_DMZ_CEN"
}

variable "transit_router_name" {
  type        = string
  description = "The name of cen transit router."
  default     = "transit_router_DMZ"
}


variable "vpcs" {
  type = object({
    dmz = object({
      cidr_block = string
      vswitches = list(object({
        subnet  = string
        zone_id = string
      }))
    })
    prod = list(object({
      cidr_block = string
      vswitches = list(object({
        subnet  = string
        zone_id = string
      }))
    }))
    dev = list(object({
      cidr_block = string
      vswitches = list(object({
        subnet  = string
        zone_id = string
      }))
    }))
    prod_inner = optional(list(object({
      cidr_block = string
      vswitches = list(object({
        subnet  = string
        zone_id = string
      }))
    })), [])
    dev_inner = optional(list(object({
      cidr_block = string
      vswitches = list(object({
        subnet  = string
        zone_id = string
      }))
    })), [])
  })
  default = {
    dmz = {
      cidr_block = null
      vswitches  = []
    }
    prod = []
    dev  = []
  }
  description = "The parameters of VPCs."
}


variable "resource_group_id" {
  description = "The ID of the resource group."
  type        = string
  default     = null
}

variable "tags" {
  description = "The tags of the resource."
  type        = any
  default     = null
}
