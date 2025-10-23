go mod edit -go=1.24
go mod tidy -go=1.24.4
go mod tidy -compat=1.24.4

# clean up caches:
go clean -cache -testcache -modcache

# check for vulnerable packages:
go install golang.org/x/vuln/cmd/govulncheck@latest
govulncheck -show=verbose .

# find out what go version was used to build a binary
$ gdb --batch -iex "set auto-load no" -ex "p 'runtime.buildVersion'" aws-rotate-key
$1 = 0x83e866 "go1.12.10"

# go get and link
go get -u github.com/stefansundin/aws-rotate-key
ln -s $GOPATH/src/github.com/stefansundin/aws-rotate-key code/aws-rotate-key
cd code/aws-rotate-key

# compile smaller binaries - https://golang.org/cmd/link/
go build -ldflags="-s -w"

# remove local paths from binary
go build -trimpath

# cross-compile - https://golang.org/doc/install/source#environment
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

# download a specific go version
go install golang.org/dl/go1.17@latest
go1.17 download
alias go=go1.17

# download the bleeding edge build
go install golang.org/dl/gotip@latest
gotip download
gotip version
