include {
  path = find_in_parent_folders()
}

terraform {
  source  = "git::github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.64.0"
}

inputs = {
  name = "test"
  cidr = "10.0.0.0/16"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
