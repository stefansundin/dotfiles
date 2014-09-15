<pre>
sudo pecl install xdebug
vim php-cgi.ini
<b>zend_extension=/usr/lib/php5/20131226/xdebug.so</b>
mkdir mytracedir
php-cgi -d xdebug.auto_trace=ON -d xdebug.trace_output_dir=mytracedir/ twitter-rss.php user=ubuntu
</pre>
