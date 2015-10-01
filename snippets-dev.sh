echo "data:image/png;base64,`cat image.png | base64`" | pbcopy

# Subresource integrity hashing https://srihash.org/
echo -n "sha384-"; curl -s https://code.jquery.com/jquery-2.1.4.min.js | openssl dgst -sha384 -binary | openssl enc -base64 -A
