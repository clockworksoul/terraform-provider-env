# The Env Terraform Provider

The Flatiron Health (FH) provider is used to describe and deploy services on Flatiron Health's networks. The provider needs to be configured with the proper Docker repository credentials before it can be used.

This provider is meant to be used in conjunction with the [Flatiron Deployment Module](https://git.the.flatiron.com/terraform-modules/deployment)!

## Example Usage

```hcl
# Configure the FH Provider
provider "fh" {
    server_address = "docker.flatiron.io"
}

# Define a container service
resource "fh_container_service" "example" {
  name  = "example"
  image = "nginx:1.17"

  port {
    container_port = 80
    host_port      = 80
  }
}
```

## Authentication

The FH provider offers a flexible means of providing credentials for authentication with our private Docker repository. The following methods are supported, in this order, and explained below:

* Static credentials
* Environment variables (recommended)

Unfortunately, because credentials specified by using `docker login` are generally stored in an OS keychain, they are not accessible as a credential source.

### Static credentials

----

**Warning: Hard-coding credentials into any Terraform configuration is not recommended, and risks secret leakage should this file ever be committed to a public version control system.**

----

Static credentials can be provided by adding `server_address` (typically `docker.flatiron.io`), `username` and `password`  in-line in the FH provider block:

Usage:

```hcl
provider "fh" {
  server_address = "docker.flatiron.io"
  username       = "jschmoe"
  password       = "totallyN0Tapa55word"
}
```

Note that setting your FH credentials using static credentials will override the use of environment variabled.

### Environment variables

You can provide your credentials via the `FH_SERVER_ADDRESS`, `FH_USERNAME` and `FH_PASSWORD` environment variables, representing the Docker repository server address, your username and password, respectively.

```hcl
provider "fh" {}
```

Usage:

```bash
$ export FH_SERVER_ADDRESS="docker.flatiron.io"
$ export FH_USERNAME="jschmoe"
$ export FH_PASSWORD='totallyN0Tapa55word'
$ terraform plan
```

## Argument Reference

The following arguments are supported in the FH provider block:

* `auth` - (Optional) Docker auth hash, which may be provided as an alternative to username+password+server. Can also be sourced from the `FH_AUTH` environment variable. If provided, this is used instead of username+password+server. Note that this value can still be decoded top retrieve credentials, so it should also be kept secret.

* `password` - (Optional) Docker registry login password. It must be provided, but it can also be sourced from the `FH_PASSWORD` environment variable.

* `server_address` - (Optional) The host address of the private docker registry. This is usually `docker.flatiron.io`.

* `username` - (Optional) Docker registry login username. It must be provided, but it can also be sourced from the `FH_USERNAME` environment variable.

## Provided Resources

* [`fh_ansible_service`](documentation/fh_ansible_service.md)
* [`fh_container_service`](documentation/fh_container_service.md)

## Provided Data Sources

* [`fh_services`](documentation/fh_services.md)
* [`fh_user_data`](documentation/fh_user_data.md)

## Building and Installing

This binary is a Go plugin. In order to install it you must compile it using the Go compiler and add it to your command path. Scripts have been provided to simplify this process.

### Installing Go

_The script only works for Mac and Linux (including WSL)._

The easiest way to install Go on Mac or on WSL is to use Flatiron's Go installer script. It's designed to be idempotent: running it again will do nothing unless your version is out-of-date, in which case it will replace your older version with the newest one.

If you want, you can run the script in one line as follows:

```bash
$ wget -O - https://fh.flatiron.io/go-install.sh | bash
```

If you prefer to download it first so that you can inspect it, you can do the following:

```bash
$ wget https://fh.flatiron.io/go-install.sh
$ chmod +x go-install.sh
$ ./go-install.sh
```

### Installing the Provider

A `Makefile` has been included to simplify building, installing, and testing the provider code.

Once the Go compiler has been installed (see above), you can run the following to build and install the provider:

```bash
$ make install
```

This will build the binary for your specific system OS and architecture and move it to `/usr/local/bin/`.

### Running Tests

A `Makefile` has been included to simplify building, installing, and testing the provider code.

Once the Go compiler has been installed (see above), you can run the following to test the provider code:

```bash
$ make test
```

This runs `go test -v ./...` -- Go's built-in testing command -- in verbose mode (`-v`), on the current directory and all subdirectories (`./...`).
