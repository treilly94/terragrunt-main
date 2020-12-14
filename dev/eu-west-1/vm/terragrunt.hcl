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
  tags = yamldecode(file(find_in_parent_folders("tags.yml")))
}

inputs = {
  name                   = "test"
  instance_count         = 1

  ami                    = "ami-ebd02392"
  instance_type          = "t3.micro"
  monitoring             = true
  vpc_security_group_ids = [dependency.vpc.outputs.default_security_group_id]
  subnet_id              = dependency.vpc.outputs.private_subnets[0]

  tags = local.tags
}
