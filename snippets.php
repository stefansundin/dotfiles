sudo pecl install xdebug
vim php-cgi.ini
  zend_extension=/usr/lib/php5/20131226/xdebug.so
mkdir mytracedir
php-cgi -d xdebug.auto_trace=ON -d xdebug.trace_output_dir=mytracedir/ twitter-rss.php user=ubuntu
php -r 'echo base64_encode(stream_get_contents(STDIN));' < ajax-loader.gif > ajax-loader.txt
php -r 'echo base64_decode(stream_get_contents(STDIN));' < ajax-loader.txt > ajax-loader.gif

cd blog
rm latest.tar.gz
wget https://wordpress.org/latest.tar.gz
tar xzf latest.tar.gz --strip=1
