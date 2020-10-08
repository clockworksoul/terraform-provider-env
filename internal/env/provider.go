package env

import (
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

// Provider builds and returns the Env provider schema. It is consumed only by
// the main function.
func Provider() *schema.Provider {
	return &schema.Provider{
		DataSourcesMap: map[string]*schema.Resource{
			"env_env": resourceEnvEnv(),
		},
	}
}
