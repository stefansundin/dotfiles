echo "data:image/png;base64,`cat image.png | base64`" | pbcopy

# Subresource integrity hashing https://srihash.org/
echo -n "sha384-"; curl -s https://code.jquery.com/jquery-2.1.4.min.js | openssl dgst -sha384 -binary | openssl enc -base64 -A ;echo

# S/MIME certificate:
# Validate your email with certificate authority.
# Generate key and csr:
openssl req -newkey rsa:4096 -keyout your-email.key -out your-email.csr
# Submit csr to certificate authority. Download crt.
# Combine crt and key to pfx:
openssl pkcs12 -export -in your-email.crt -inkey your-email.key -out your-email.pfx
# Import pfx into browser and email client.

# Web server certificate:
# Generate key and csr:
openssl genrsa -out domain.com.key 4096
openssl req -new -sha256 -key domain.com.key -out domain.com.csr
# After the csr is approved, save the cert to domain.com.crt
wget https://www.startssl.com/certs/sub.class1.server.ca.pem
cat domain.com.crt sub.class1.server.ca.pem > domain.com-unified.crt
# Print cert information
openssl x509 -in domain.com.crt -noout -text
