include {
  path = find_in_parent_folders()
}

terraform {
  source  = "git::github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.64.0"
}

locals {
  global_vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  tags = merge(
    local.global_vars.locals.tags, 
    local.env_vars.locals.tags
    )
}

inputs = {
  name = "${local.region_vars.locals.prefix}-test"
  cidr = "10.0.0.0/16"

  azs             = [
    "eu-west-1a", 
    "eu-west-1b", 
    "eu-west-1c"
    ]

  private_subnets = [
    "10.0.1.0/24", 
    "10.0.2.0/24", 
    "10.0.3.0/24"
    ]

  tags = local.tags
}
