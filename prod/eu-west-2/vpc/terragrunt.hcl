include {
  path = find_in_parent_folders()
}

terraform {
  source  = "git::github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.64.0"
}

locals {
  global_locals = yamldecode(file(find_in_parent_folders("global.yml")))
  env_locals = yamldecode(file(find_in_parent_folders("env.yml")))
  region_locals = yamldecode(file(find_in_parent_folders("region.yml")))

  tags = merge(
    local.global_locals.tags, 
    local.env_locals.tags
    )
}

inputs = {
  name = "${local.region_locals.prefix}-test"
  cidr = "10.0.0.0/16"

  azs             = [
    "eu-west-2a", 
    "eu-west-2b", 
    "eu-west-2c"
    ]

  private_subnets = [
    "10.0.1.0/24", 
    "10.0.2.0/24", 
    "10.0.3.0/24"
    ]

  tags = local.tags
}
