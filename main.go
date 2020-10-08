package main

import (
	env "git.the.flatiron.com/terraform/providers/terraform-provider-env/internal/env"

	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: env.Provider,
	})
}
