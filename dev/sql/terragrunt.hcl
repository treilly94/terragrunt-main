include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:treilly94/terragrunt-modules.git//sql"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  env = "dev"
  vpc_uuid = dependency.vpc.outputs.vpc_id
}
