package env

import (
	"os"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func dataSourceEnvValue() *schema.Resource {
	return &schema.Resource{
		Read: dataSourceEnvValueRead,

		Schema: map[string]*schema.Schema{
			"key": {
				Type:     schema.TypeString,
				Required: true,
			},

			"exists": {
				Type: schema.TypeBool,
			},
			"value": {
				Type: schema.TypeString,
			},
		},
	}
}

func dataSourceEnvValueRead(d *schema.ResourceData, meta interface{}) error {
	key := d.Get("key").(string)
	value, exists := os.LookupEnv(key)

	d.SetId(key)

	return d.Set("metadata", []map[string]interface{}{{
		"exists": exists,
		"value":  value,
	}})
}
