"STRING".downcase
[1, 2, nil, 4].compact
[true,false].sample
File.open("file.log","a+") { |f| f.write "#{var.inspect}\n" }
u = User.first(order:"RANDOM()")
puts User.all.to_yaml
User.find(27).touch # clear IdentityCache
User.first.created_at.in_time_zone(ActiveSupport::TimeZone["America/Los_Angeles"])
y Event.all.pluck(:created_at).map{|t| t.strftime("%F") }.group_by{|e| e}.map{|k, v| [k, v.length]}.to_h
ActiveRecord::Base::sanitize
ActiveRecord::Base.transaction { users.map(&:save) }
ActiveRecord::Base.connection_pool.size
ActionController::Base.helpers.strip_tags
ActiveRecord::Base.logger = Logger.new(STDOUT) # see SQL in console
ActiveRecord::Migration.remove_column :posts, :view_count
$redis.keys.select { |k| $redis.del k } # clear redis the poor mans way
before_filter :auth, unless: -> { Rails.env.development? }

require "fileutils"
FileUtils.mkdir_p("files")

case type
when "json", "yml" then 10
when "text" then 30
else "Unknown"
end

git mv {20140918225402,`TZ=0 date +%Y%m%d%H%M%S`}_move_migration_to_last.rb
rake db:create db:setup db:migrate
rails g migration AddAutoSubscribeToUsers
rake db:migrate:status
rake db:migrate:down VERSION=20131121021805
rake db:rollback STEP=3
rake db:schema:dump db:structure:dump
rake assets:precompile
redis-cli FLUSHALL

# rbenv
# sudo apt-get install -y git build-essential libreadline-dev libxml2-dev libxslt1-dev libpq-dev libsqlite3-dev libssl-dev
# See https://github.com/garnieretienne/rvm-download for precompiled binaries
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update
git clone https://github.com/ianheggie/rbenv-binstubs.git ~/.rbenv/plugins/rbenv-binstubs
# add to ~/.bash_profile
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# add to ~/.gemrc
gem: --no-document

# run specific version of gem
gem list '^rails$'
gem install rails -v 4.2.10
rails _4.2.10_ --version

bundle config --global ignore_messages.httparty true
bundle config --global disable_version_check true

# Gems
group :development do
  gem "bullet" # help find N+1 queries
  # debug errors on exception
  gem "better_errors"
  gem "binding_of_caller"
end
# To use better_errors instead of pry, just use `raise "oops"` instead of `binding.remote_pry`.

# Render ERB / yml
require "erb"
f = "config/database.yml"
puts ERB.new(File.open(f).read).result
puts ERB.new(File.open("config/newrelic.yml").read).result

# config/environments/development.rb
  config.after_initialize do
    Bullet.enable = true
    Bullet.console = true
  end

# get location of method at runtime
u = User.find_by_uid(1005)
u.method(:statements).source_location

# longer POW timeout
# ~/.powconfig
export POW_TIMEOUT=3600

# rails 4 console automatic database connection
module App
  class Application < Rails::Application
    # Automatically establish database connection in the rails console
    console do
      ActiveRecord::Base.connection rescue nil
    end
  end
end

# sidekiq inline
# config/environments/development.rb
require "sidekiq/testing/inline"

# cancel specific jobs in sidekiq retry queue
Sidekiq::RetrySet.new.each { |job| job.delete if job.klass == "AwesomeButFailingJob" }
Sidekiq::ScheduledSet.new.select { |job| job.klass == "AwesomeButFailingJob" }.count

# clear sidekiq queues
Sidekiq::Queue.all.map(&:clear)
Sidekiq::ScheduledSet.new.clear
Sidekiq::RetrySet.new.clear

# resque stdout logging
# config/initializers/resque.rb
if Rails.env.development?
  Resque.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

# clear resque queues
Resque.queues.each { |q| Resque.remove_queue(q) }
Resque.workers.each(&:unregister_worker)
#Resque.workers.map(&:id).each { |id| Resque.remove_worker(id) }

# profile
require "profiler"
Profiler__.start_profile
Profiler__.stop_profile
Profiler__.print_profile(File.open("profile-#{Time.now.to_i}.log","wb"))

# ~/.pryrc
# fix for NoMethodError: undefined method `reload!' for main:Object
include Rails::ConsoleMethods if defined? Rails

# check what readline is in use
# this is good:
Readline::VERSION
=> "6.3"
# this is bad:
Readline::VERSION
=> "EditLine wrapper"


# continue the program but ignore binding.pry
disable-pry

# for pry-remote it's more complicated
# application.rb:
module AwesomeApp
  class Application < Rails::Application
    REMOTE_PRY_ENABLED = Time.now()
  end
end
# use this in code
binding.remote_pry if Time.now() > AwesomeApp::Application::REMOTE_PRY_ENABLED
# use this in pry-remote session to continue
AwesomeApp::Application::REMOTE_PRY_ENABLED = Time.now()+1.minute
AwesomeApp::Application::REMOTE_PRY_ENABLED = Time.now()+10.seconds


# database.yml
development:
  # url: postgresql:///APP_development?pool=30

test:
  # url: postgresql:///APP_test?pool=30

<% if ENV["DATABASE_URL"] %>
production:
  url: <%= ENV["DATABASE_URL"] %>?pool=30
<% end %>


# print database config
ActiveRecord::Base.connection_config
Rails.application.config.database_configuration

# kill all connections to database
psql -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='app_development';"

# find out database size
psql -t -c "SELECT pg_size_pretty(pg_database_size(current_database()))" app_development
 357 MB

# raw queries
def sql(*args)
  ActiveRecord::Base.connection.execute(*args).to_a
end
sql "SHOW SERVER_VERSION"
=> [{"server_version"=>"9.1.11"}]

res = ActiveRecord::Base.connection.execute("SELECT * FROM VOTES WHERE votable_type = 'Post' AND created_at > NOW()-'1 day'::INTERVAL")
res.count
res[1]

# Database truthy and falsy values
ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES
=> #<Set: {true, 1, "1", "t", "T", "true", "TRUE", "on", "ON"}>
ActiveRecord::ConnectionAdapters::Column::FALSE_VALUES
=> #<Set: {false, 0, "0", "f", "F", "false", "FALSE", "off", "OFF"}>

# symbolize keys
def symbolize_keys_deep(h)
  if h.kind_of? Hash
    h.map { |k,v| [k.to_sym, symbolize_keys_deep(v)] }.to_h
  elsif h.kind_of? Array
    h.map { |v| symbolize_keys_deep(v) }
  else
    h
  end
end

# HTTParty
require "httparty"

class HTTPartyDebug
  include HTTParty
  debug_output $stdout
  default_timeout 5
  def method_missing(m)
    self.first.send m
  end
end

HTTPartyDebug.post("https://www.googleapis.com/youtube/v3/subscriptions?part=snippet", headers: { "Content-Type" => "application/json", "Authorization" => "Bearer ya29.1" }, body: {snippet: {resourceId: {channelId: "UCOxsR_7dUEp6p2inmL1ZHiA"}}}.to_json)


# forward arguments
alias :really_display :display
def display(*args)
  super args.inspect
  super *args
end


# time code
def time
  start = Time.now
  yield
  eta = Time.now - start
  mm, ss = eta.divmod(60)
  hh, mm = mm.divmod(60)
  dd, hh = hh.divmod(24)
  puts "[%s] Took %d days %2d hours %2d minutes %2d seconds." % [Time.now.strftime("%T"), dd, hh, mm, ss]
  eta
end
time { User.each { |u| u.update_attribute :locale, "en" } }


# strip unknown characters
body = HTTParty.get("http://gdata.youtube.com/feeds/api/videos/VtI5HM7GVGY")
JSON.parse(body)
(pry) output error: #<Encoding::UndefinedConversionError: "\xC2" from ASCII-8BIT to UTF-8>
body = body.force_encoding("ASCII-8BIT").encode("UTF-8", undef: :replace, replace: "")
JSON.parse(body)


# tempfile
file = Tempfile.new(['avatar','.png'])
file.binmode
file.write Base64.decode64("iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAD1klEQVR4Xu1aS2gTQRhOrFVCVaRSpAcVKSr0VhCSQ+sDRMWAihBBPQhF0JN6UIqoRylBD3pTkIIXBQOCQkRF8NFCExB6slA9qPVQq9CK2oNtpW7+yRcyfzLZbLqTNJnZy2QeOzv7fd//mNkEA4ZfQcPfP2ABsAowHAFrAoYLwDpBawLWBDQjEA6HFzKPSKfTktrQjser+nm738vVbgLGAoAXf/EqRaTt3R2RyBu49Feq9/avlOr8Pl1K0KYAC0DW9sHkyIefxHDf6f1Upp73SIxH9g1SPX7nGZVdW9dKyql7BRgLAGgORy9IjKeTN6S6W3/dKsAYAHhcx4vD23Mvr/IBbvep8oZK8wPfokDdAqBauFeb42EPjPD4n2P+7HcaMjY8TOW/6y1UqvIBPp/X9akUEjQegIX5z5Srz4+dJ5C6eydkb81yeDdbA6CI54+evKRb4PXhE5ouzlD7+PQ0lcv626i8fHcNlYgKRw7uoTryB7+Yx3sEjQdg7v1hUsDybTcJFK4Er4irTIor59qpX1ITmHdTmNf1uM0XNB4AMDY00E5geVWCG+OD53bSvM3H4hIZkYi8O0ylxK4R19yDPvrZc+tNSRIXq4hcFDAeAMBcLhBgHnF99LXw9hM/xD4fNg2v33lohNrBPJSB54JpKGH0cRd1IS+Az2hvE+cGnbtEdMAuslIlFOQBxgHADcyrT+BKwHxgBsxt2b6aujZu3lHSpsc/vaX+j+9+S0pS7R0qZR6LKNgLGA8AkKkUCE5vKBSipisnJqWucuN+Sbk4nb4rwALAIC9XCZwpOFO+t+DjePx3YzznY7J5hDYFeFVCwwLgFQh+AsSVgKgAH5BMJukRk0Mirq/atILKP19mi9bXd4t8IxqNUqldARaARfoErgDEc+QJUMDM1wMlmYcyWjY8rY0CvCoB4xsOAK9AcAAe3qbjh8DRMyIHK9cH4Lk1V4CxAKi+5xfkCXFxpofT3pOtrZIX4XuDcpXAvT8mrXoU4A82DgC3DO/e1BRhhNPeqx0dRRWARp4PqKIBt/2aKcBYAFTOj6UJBd8V0M8zQH4f6ogKvB+ZHxQG31I1H2ABYJS4nQZjOOI+6vykx6tCuDKqrgCuBJWUGx6AEi/enOlzFELbuRJnecfz53DG33cZvy47XoQZny7f/h+Qtx7jAQAW9Dcvh1nx+Td7OTYrMc+JhBLyxotPVoHAN59Il6bRoQALQDGmYrFYU6Y9kUiIDwTOXwIUjEIxYtuo+dKpAGnpxgOgmciKp6+aAipeoeYbLQCaAV7y01sFLHmKNC/QKkAzwEt++v9cZoJuEXyVAgAAAABJRU5ErkJggg==")
file.flush


# status codes
100 = :continue
101 = :switching_protocols
102 = :processing
200 = :ok
201 = :created
202 = :accepted
203 = :non_authoritative_information
204 = :no_content
205 = :reset_content
206 = :partial_content
207 = :multi_status
226 = :im_used
300 = :multiple_choices
301 = :moved_permanently
302 = :found
303 = :see_other
304 = :not_modified
305 = :use_proxy
307 = :temporary_redirect
400 = :bad_request
401 = :unauthorized
402 = :payment_required
403 = :forbidden
404 = :not_found
405 = :method_not_allowed
406 = :not_acceptable
407 = :proxy_authentication_required
408 = :request_timeout
409 = :conflict
410 = :gone
411 = :length_required
412 = :precondition_failed
413 = :request_entity_too_large
414 = :request_uri_too_long
415 = :unsupported_media_type
416 = :requested_range_not_satisfiable
417 = :expectation_failed
422 = :unprocessable_entity
423 = :locked
424 = :failed_dependency
426 = :upgrade_required
500 = :internal_server_error
501 = :not_implemented
502 = :bad_gateway
503 = :service_unavailable
504 = :gateway_timeout
505 = :http_version_not_supported
507 = :insufficient_storage
510 = :not_extended


# cleanup
psql --list
dropdb _test
vacuumdb -a -f -F
rm ~/Library/Application\ Support/Postgres93/var/pg_log/*

# stop postgres to clean the pg_xlog directory
pg_resetxlog ~/Library/Application\ Support/Postgres93/var/
rm ~/Library/Logs/Pow/access.log

# /usr/local/etc/mongod.conf
smallfiles=true

launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
rm /usr/local/var/mongodb/journal/*
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist


# build gem
git clone https://github.com/jugyo/tunnels
cd tunnels
gem build tunnels.gemspec
gem install tunnels-1.2.0.gem

# create key for signing gems
gem cert --build email@gmail.com --days 3650
openssl x509 -in gem-public_cert.pem -noout -text

openssl req -nodes -new -x509 -keyout server.key -out server.crt -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=*.dev"
sudo tunnels

# Mac OS X instructions
# Click padlock icon -> Certificate Information -> Drag certificate image to desktop, this will export the certificate
# Double click certificate and add it to the Keychain. Click [Always Trust]. You have to double click the certificate again, expand Trust section, change When using this certificate: [Always Trust].


# Heroku
heroku logs -t -n2500
heroku pg:psql
heroku pg:info
heroku pg:credentials COPPER

# Heroku pull database
heroku pgbackups:capture --expire
heroku pgbackups
heroku pgbackups:url
curl -o db-`date +%F`.dump `heroku pgbackups:url`
powder down
createdb _development
pg_restore --verbose --clean --no-acl --no-owner -d _development db-`date +%F`.dump

# Heroku + Logentries (Syslog drain)
# Manual Configuration. (x) Plain TCP, UDP.
heroku drains:add syslog://data.logentries.com:XXXXX


# Parse AWS ip-ranges
r = HTTParty.get "https://ip-ranges.amazonaws.com/ip-ranges.json"
puts r.parsed_response["prefixes"].select { |p| p["region"].start_with?("us") and p["service"] == "AMAZON" }.map { |p| p["ip_prefix"] }.join("\n")
