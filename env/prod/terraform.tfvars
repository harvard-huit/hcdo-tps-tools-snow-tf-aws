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
jail_sg                   = false

snow_instance_ingress_rules = {
}

snow_instance_egress_rules = {
}

snow_instances = {
  0 = {
    name          = "snow-prod-instance-01"
    ami_id        = "ami-035bfb8c022c29b0f" # Windows Server 2022 Golden Image
    subnet_id     = "subnet-66a0c149"
    instance_type = "c8i-flex.xlarge"
    key_name      = "esm-prod-snow-instance"
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
    additional_ebs_block_devices = {
      01 = {
        device_name = "/dev/sdb"
        volume_type = "gp3"
        volume_size = 50
      }
    }
  }
}
