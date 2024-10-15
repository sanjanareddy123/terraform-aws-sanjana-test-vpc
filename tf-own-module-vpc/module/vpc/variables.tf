variable "vpc_config" {
  description = "To the cidr and name of the vpc from the user"
  type = object({
   name = string
   cidr_block = string
 })
 validation {
   condition = can(cidrnetmask(var.vpc_config.cidr_block))
   error_message = "invalid cidr block range - ${var.vpc_config.cidr_block}"
 }
  
}

variable "subnets_config" {
    description = "value"
    type = map(object({
      cidr_block = string
      azs = string
      public = optional(bool,false)
    }))

    validation {
      condition = alltrue([for config in var.subnets_config : can(cidrnetmask(config.cidr_block)) ])
      error_message = "invalid cidr block range "
    }
  
}



