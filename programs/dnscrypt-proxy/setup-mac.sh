brew install dnscrypt-proxy mkcert nss
mkcert -install

cd /opt/homebrew/etc/
mkcert localhost 127.0.0.1 ::1
wget -O dnscrypt-blocklist-mybase.txt https://download.dnscrypt.info/blacklists/domains/mybase.txt

# Update dnscrypt-proxy.toml


# Run dnscrypt-proxy in terminal:
sudo /opt/homebrew/opt/dnscrypt-proxy/sbin/dnscrypt-proxy -config /opt/homebrew/etc/dnscrypt-proxy.toml

# List config options without comments:
cat dnscrypt-proxy.toml | grep -v -E '^ *#' | grep .
