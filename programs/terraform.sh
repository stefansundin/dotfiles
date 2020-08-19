# get data from remote state:
terraform state pull | jq -Mr .terraform_version
