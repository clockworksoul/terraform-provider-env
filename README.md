# The Env Terraform Provider

## Example Usage

```hcl
terraform {
  required_providers {
    env = {
      source  = "clockworksoul/env"
      version = "0.0.2"
    }
  }
}
```

## Using the Value Data Source

```hcl
data "env_value" "environment" {
  key = "ENV"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
    env  = data.env_value.environment.value
  }
}
```
