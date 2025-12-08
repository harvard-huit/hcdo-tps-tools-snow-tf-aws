# -----------------------------------------
# REQUIRED VALUES 
# -----------------------------------------

# Product Context Variables
product_name              = "snow"
product_name_short        = "snow"
product_environment       = "production"
product_environment_short = "prod"
product_asset_id          = 6250
product_context           = "standard"
product_criticality       = "Non-Critical"
product_data_class        = "nonlevel4"
product_hosted_by         = "DevOps-APT6"

shared_values_prefix = "SharedValues-esm-prod"

iam_instance_profile_name = "esm-prod-snow-instance-role"
jail_sg                   = true
lift_and_shift            = true

snow_instance_ingress_rules = {
}

snow_instance_egress_rules = {
}

snow_instances = {
  0 = {
    ami_id        = "ami-0a69756aba806579b"
    instance_type = "c8i-flex.xlarge"
    key_name      = "snow-prod-standard"
    static        = true
    platform      = "windows"
    backup_policy = "11PM_DAILY"
    patch_policy  = "Week1"
    jail_sg       = false
    create        = true
    root_block_device = [
      {
        volume_type = "gp3"
        volume_size = 80
      },
    ]
    modify_existing_ebs_block_devices = {
      01 = {
        device_name = "/dev/sdb"
        volume_type = "gp3"
        volume_size = 50
      }
    }
  }
}
