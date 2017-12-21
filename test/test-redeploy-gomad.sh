curl -X POST \
  'http://localhost:9000/hooks/redeploy-gomad?token=SUPER_SECRET' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
  "pushdata": {
  	"tag": "latest"
  }
}'
