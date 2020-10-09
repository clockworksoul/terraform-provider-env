.DEFAULT_GOAL := help

NAME := env
VERSION := 0.0.2
OS := darwin
ARCH := amd64

help:
	@echo "Usage:"
	@echo "  make [command]"
	@echo
	@echo "Available Commands:"
	@echo "  make build    Build go binary into this directory"
	@echo "  make clean    Remove generated files"
	@echo "  make help     Show this message"
	@echo "  make install  Install the binary to /usr/local/bin"
	@echo "  make test     Run Go tests"

clean:
	@echo "* Deleting local binary (if present)"
	@rm -fv ./terraform-provider-${NAME}*

build: clean
	@echo "* Building provider binary"
	@go build -o ./terraform-provider-${NAME}_v${VERSION} .
	@chmod 755 ./terraform-provider-${NAME}_*

test:
	@go test -v ./...

release: build
	@zip terraform-provider-${NAME}_${VERSION}_${OS}_${ARCH}.zip terraform-provider-${NAME}_v${VERSION}
	@shasum -a 256 *.zip > terraform-provider-${NAME}_${VERSION}_SHA256SUMS
	@gpg --detach-sign terraform-provider-${NAME}_${VERSION}_SHA256SUMS
