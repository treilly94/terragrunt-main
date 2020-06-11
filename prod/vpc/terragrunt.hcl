include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:treilly94/terragrunt-modules.git//vpc"
}

inputs = {
  env = "prod"
  ip_range = "10.10.20.0/24"
}
