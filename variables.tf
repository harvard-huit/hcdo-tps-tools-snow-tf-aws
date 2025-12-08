variable "shared_values_prefix" {
  description = <<EOT
      The prefix to use for the SharedValues CloudFormation imports.  The default "SharedValues" value will utilize the CS1 SharedValues exports.
      The following examples show you how to use a CS2 SharedValues export:
        Example: SharedValues-cloudhacks-dev
        Example: SharedValues-hup-prod
    EOT
  type        = string
}

# Product Context Variables

variable "product_name" {
  description = "Identifies this project. This name is used within various resource's 'Name' tag, DNS entries, to determine S3 locations, and so on."
  type        = string
}

variable "product_name_short" {
  description = "Identifies this project. This Short name is used within various resource's 'Name' tag, DNS entries, to determine S3 locations, and so on."
  type        = string
}

variable "product_environment" {
  description = "Which stage of development is this stack being provisioned for (long form, e.g. 'Development')?"
  type        = string
}

variable "product_environment_short" {
  description = "Which stage of development is this stack being provisioned for (short form, e.g. 'dev')?"
  type        = string
}

variable "product_asset_id" {
  description = "The HUIT asset id associated to this product. This value must be procured before stack creation in order to insure accurate billing."
  type        = number
  default     = -1
}

variable "composite_name" {
  description = "Used as an override to support pre-existing resource names that don't fit the new naming scheme."
  type        = string
  default     = ""
}
variable "product_context" {
  description = " The security context applied to this product. This determines which subnets CloudFormation will deploy the product into and if it creates various resources to meet a given context's compliance requirements, e.g. KMS."
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["level4", "standard"], var.product_context)
    error_message = "Product Context must be on of the following values: 'level4' or 'standard'"
  }
}

variable "product_hosted_by" {
  description = " (Optional) The HUIT hosted by group. This is used by reporting and operations e.g. DevOps-APT12, DevOps-APT3, etc. This value must be set if managed by DevOps.  The default is 'Not-Defined'."
  type        = string
  default     = "Not-Defined"
  validation {
    condition     = contains(["DevOps-APT12", "DevOps-APT3", "DevOps-APT4", "DevOps-APT4-OT", "DevOps-APT5", "DevOps-APT6", "DevOps-APT7", "DevOps-APT8", "Not-Defined"], var.product_hosted_by)
    error_message = "Produce hosted_by value must be on of the following values: 'DevOps-APT12', 'DevOps-APT3', 'DevOps-APT4', 'DevOps-APT4-OT', 'DevOps-APT5', 'DevOps-APT6', 'DevOps-APT6', 'DevOps-APT6', 'Not-Defined'"
  }
}

variable "product_criticality" {
  description = "(Optional) The criticality of this product. This value must correspond with the product rating as listed in ServiceNow -> HUIT Config -> Application. The default is 'Non-Critical'."
  type        = string
  default     = "Non-Critical"
  validation {
    condition     = contains(["Foundational/Life Safety", "Mission Critical", "Critical", "Important", "Non-Critical"], var.product_criticality)
    error_message = "Product Criticality must be on of the following values: 'Foundational/Life Safety', 'Mission Critical', 'Critical', 'Important', or 'Non-Critical'"
  }
}

variable "product_data_class" {
  description = "(Optional) The data class of the data stored in this product. This value is generally calculated by subnet placement - e.g. in a level4 subnet."
  type        = string
  default     = "nonlevel4"
  validation {
    condition     = contains(["level4", "nonlevel4"], var.product_data_class)
    error_message = "Product data_class must be on of the following values: 'level4' or 'nonlevel4'"
  }
}
variable "tier" {
  description = "The application tier being deployed, e.g. app, db, lb_pub, or lb_priv."
  type        = string
  default     = "app"

  validation {
    condition     = contains(["app", "db", "lb_pub", "lb_priv"], var.tier)
    error_message = "Tier must be one of the following values: 'app', 'db', 'lb_pub', or 'lb_priv'"
  }
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile to use for the EC2 instances"
  type        = string
}

variable "jail_sg" {
  description = "(Optional) Whether to enable the jail security group for the EC2 instances."
  type        = bool
  default     = false
}

variable "lift_and_shift" {
  description = "(Optional) Whether to enable lift-and-shift policy for the KMS key."
  type        = bool
  default     = false
}

variable "snow_instances" {
  description = "A map of EC2 instance configurations. Each key is a unique identifier for the instance, and the value is a map containing the instance's configuration details."
  type = map(object({
    name          = string
    static        = bool
    platform      = optional(string)
    backup_policy = optional(string)
    instance_type = string
    jail_sg       = bool
    patch_policy  = string
    key_name      = string
    ami_id        = string
    create        = bool
    sg_name       = optional(string)
    domain_name   = optional(string)
    subnet_id     = optional(string)
    root_block_device = optional(list(object({
      volume_type           = string
      volume_size           = number
      delete_on_termination = optional(bool)
      snapshot_id           = optional(string)
      iops                  = optional(number)
      throughput            = optional(number)
    })))
    modify_existing_ebs_block_devices = optional(map(object({
      device_name           = string
      volume_type           = string
      volume_size           = number
      delete_on_termination = optional(bool)
      snapshot_id           = optional(string)
      iops                  = optional(number)
      throughput            = optional(number)
    })))
  }))
  default = {}
}

variable "snow_instance_ingress_rules" {
  description = "A map of ingress security group rules for the snow instances security group. Each key is a unique identifier for the rule, and the value is a map containing the rule's details."
  type = map(object({
    from_port                    = optional(number)
    to_port                      = optional(number)
    ip_protocol                  = optional(string)
    cidr_ipv4                    = optional(string)
    description                  = optional(string)
    referenced_security_group_id = optional(string)
  }))
  default = {}

}

variable "snow_instance_egress_rules" {
  description = "A map of egress security group rules for the snow instances security group. Each key is a unique identifier for the rule, and the value is a map containing the rule's details."
  type = map(object({
    from_port                    = optional(number)
    to_port                      = optional(number)
    ip_protocol                  = optional(string)
    cidr_ipv4                    = optional(string)
    description                  = optional(string)
    referenced_security_group_id = optional(string)
  }))
  default = {}

}
