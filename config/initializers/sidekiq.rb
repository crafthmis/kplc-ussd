require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  #[user, password] == ["KenyapowerServices@kplc.co.ke", "Kplc@12345"] # Y#n*MNr8(e+]H
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(user), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
end

schedule_file = "config/schedule.yml"

if File.exists?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://127.0.0.1:6379', size: 1, network_timeout: 5 }
# end

# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://127.0.0.1:6379', size: 27, network_timeout: 5 }
# end

# Sidekiq::Extensions.enable_delay!

sidekiq_config = { url: ENV['REDIS_URL'] }
#sidekiq_config = { url: 'redis://172.16.3.54:6379' }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end


