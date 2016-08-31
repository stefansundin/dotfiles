# vendor things with git submodules
mkdir -p vendor/github.com/aws
cd vendor/github.com/aws
git submodule add https://github.com/aws/aws-sdk-go

# compile smaller binaries - https://golang.org/cmd/link/
go build -ldflags="-s -w"

# cross-compile - https://golang.org/doc/install/source#environment
GOOS=linux GOARCH=amd64 go build
