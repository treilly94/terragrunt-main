include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::github.com/terraform-aws-modules/terraform-aws-ec2-instance?ref=v2.16.0"
}

dependency "vpc" {
  config_path = "../vpc"
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
  name                   = "${local.region_locals.prefix}-test"
  instance_count         = 1

  ami                    = local.region_locals.ami
  instance_type          = "t3.micro"
  monitoring             = true
  vpc_security_group_ids = [dependency.vpc.outputs.default_security_group_id]
  subnet_id              = dependency.vpc.outputs.private_subnets[0]

  tags = local.tags
}
