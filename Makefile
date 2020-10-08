.DEFAULT_GOAL := help

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
	@rm -fv ./terraform-provider-env

build: clean
	@echo "* Building provider binary"
	@go build -o terraform-provider-env .
	@chmod 755 terraform-provider-env

install: build
	@echo "* Installing terraform-provider-env into /usr/local/bin/"
	@sudo mv terraform-provider-env /usr/local/bin/
	@which terraform-provider-env

test:
	@go test -v ./...
