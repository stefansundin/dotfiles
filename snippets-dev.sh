echo "data:image/png;base64,`cat image.png | base64`" | pbcopy

# Subresource integrity hashing https://srihash.org/
echo -n "sha384-"; curl -s https://code.jquery.com/jquery-2.1.4.min.js | openssl dgst -sha384 -binary | openssl enc -base64 -A ;echo

# Generate SSL key and CSR
openssl genrsa -out domain.com.key 2048
openssl req -new -sha256 -key domain.com.key -out domain.com.csr
