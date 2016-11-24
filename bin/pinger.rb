#!/usr/bin/env ruby
require "net/http"

url = ARGV.first
abort "Specify url to ping." if url.nil?
puts "Pinging #{url}"

uri = URI(url)
while true
  res = Net::HTTP.get_response(uri)
  if res.code == "200"
    color = "\033[32m"
  else
    color = "\033[31m"
  end
  puts "#{Time.now}   =>   #{color}#{res.code}\033[0m"
  sleep(1)
end
