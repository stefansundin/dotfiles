go mod edit -go=1.15

# clean up caches:
go clean -cache -testcache -modcache

# find out what go version was used to build a binary
$ gdb --batch -iex "set auto-load no" -ex "p 'runtime.buildVersion'" aws-rotate-key
$1 = 0x83e866 "go1.12.10"

# go get and link
go get -u github.com/stefansundin/aws-rotate-key
ln -s $GOPATH/src/github.com/stefansundin/aws-rotate-key code/aws-rotate-key
cd code/aws-rotate-key

# compile smaller binaries - https://golang.org/cmd/link/
go build -ldflags="-s -w"

# cross-compile - https://golang.org/doc/install/source#environment
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build
