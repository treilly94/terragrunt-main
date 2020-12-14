include {
  path = find_in_parent_folders()
}

terraform {
  source  = "git::github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.64.0"
}

locals {
    tags = yamldecode(file(find_in_parent_folders("tags.yml")))
}

inputs = {
  name = "test"
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
