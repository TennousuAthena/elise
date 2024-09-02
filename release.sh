# $1 directory
function pack() {
  cd "$1/" || exit
  zip -r "../$1.zip" *
  cd ../
}

GOOS=linux go build -ldflags "-w -s -X 'main.version=$1'" -o release/linux/elise cmd/elise/main.go
GOOS=darwin_amd64 go build -ldflags "-w -s -X 'main.version=$1'" -o release/darwin_amd64/elise cmd/elise/main.go
GOOS=darwin_arm64 go build -ldflags "-w -s -X 'main.version=$1'" -o release/darwin_arm64/elise cmd/elise/main.go
GOOS=windows go build -ldflags "-w -s -X 'main.version=$1'" -o release/windows/elise.exe cmd/elise/main.go

cd release || exit

pack "linux"
pack "darwin_amd64"
pack "darwin_arm64"
pack "windows"