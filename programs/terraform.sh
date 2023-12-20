# get data from remote state:
terraform state pull | jq -Mr .terraform_version

terraform0.14 state pull > terraform.tfstate
