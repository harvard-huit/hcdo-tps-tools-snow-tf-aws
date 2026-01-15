# Additional instructions for using this backend can be found here: https://developer.hashicorp.com/terraform/language/settings/backends/s3
terraform {
  backend "s3" {
    bucket       = "esm-dev-standard-terraform-state-bucket" # Update accordingly with your remote state bucket name.
    key          = "snow/int/terraform.tfstate"              # Make sure this value is unique, especially if using the same cloudhacks bucket.
    use_lockfile = true

    region = "us-east-1" # Update for your environment.
  }
}
