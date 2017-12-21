# gomad

Example webhook listener to rerun Nomad jobs when triggered. Assumes Consul KV store integration.

Pulls `hooks.json` configuration from Consul KV `gomad/hooks.json`.

## Usage

```
$ nomad run hooks/gomad.nomad
$ curl -X POST \
  'http://gomad.nomad.mydomain.example/hooks/redeploy-gomad?token=SUPER_SECRET' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
  "pushdata": {
  	"tag": "latest"
  }
}'
```

You will need to configure your routes to make this service accessible. `pushdata.tag` is for Docker Hub webhooks.
