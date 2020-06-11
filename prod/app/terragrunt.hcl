include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:treilly94/terragrunt-modules.git//app"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  env = "prod"
  vpc_uuid = dependency.vpc.outputs.vpc_id
}
