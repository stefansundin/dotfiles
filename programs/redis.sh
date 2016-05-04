# Bash helper
function r {
  url=$1
  shift
  redis-cli $(echo "$url" | sed -E -e 's/redis:\/\/([^:]*)?:/-a /' -e 's/\@/ -h /' -e 's/:/ -p /' -e 's/\///g') "$@"
}

# Clean up idle connections
redis-cli -a REDISPASSWORDHERE CLIENT LIST | while read addr fd name age idle splat; do
  idle=$(echo $idle | cut -d'=' -f2)
  if [[ $idle -gt 10000 ]]; then
    addr=$(echo $addr | cut -d'=' -f2)
    echo "CLIENT KILL $addr"
  fi
done | redis-cli -a REDISPASSWORDHERE -x
