env = (ENV["IRB_PROMPT"] || ENV["RACK_ENV"] || "unknown").upcase
if env == "PRODUCTION" or env == "DEPLOYMENT"
  color = "31"
else
  color = "33"
end

IRB.conf[:PROMPT][:CUSTOM] = {
  PROMPT_I: "%03n \e[#{color}m#{env} >>\e[0m ",
  PROMPT_N: "%03n \e[#{color}m#{env} \e[1;33m>>\e[0m ",
  PROMPT_S: nil,
  PROMPT_C: "%03n \e[#{color}m#{env} \e[33m?>\e[0m ",
  RETURN:   "\e[#{color}m#{env} \e[32m=>\e[0m %s\n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM

def sql(*args)
  ActiveRecord::Base.connection.execute(*args).to_a
end

def clear_sidekiq
  Sidekiq::Queue.all.map(&:clear)
  Sidekiq::ScheduledSet.new.clear
  Sidekiq::RetrySet.new.clear
end

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

require 'time'

class Time
  def to_la
    self.getlocal("-08:00")
  end
end
