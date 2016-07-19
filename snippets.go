# vendor things with git submodules
mkdir -p vendor/github.com/aws
cd vendor/github.com/aws
git submodule add https://github.com/aws/aws-sdk-go
