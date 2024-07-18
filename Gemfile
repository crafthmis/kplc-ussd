source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4' #5.2.3
# Use postgresql as the database for Active Recorde

gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'bootstrap', '~> 4.3.1'
gem 'rails_12factor'

gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f'
gem 'acts_as_tenant'
gem 'sass-rails', '~> 5.0'
gem 'public_activity','~> 1.6.4'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'pghero','~> 2.7.3'
gem 'pg_query', '>= 0.9.0'
gem 'hightop','~> 0.2.4'

gem 'nested_form_fields','~> 0.8.4'

gem 'geocoder','~> 1.6.4'
gem 'gmaps4rails','~> 2.1.2'

gem "pundit",'~> 2.1.0'

gem 'data_migrate','~> 6.6.0'

gem 'kaminari','~> 1.2.1'
gem 'caxlsx','~> 3.0.3'
gem 'caxlsx_rails','~> 0.6.2'

gem "roo", "~> 2.8.0"
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'record_tag_helper', '~> 1.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'redis', '~> 3.2'
gem 'hiredis', '~> 0.4.5'
gem 'redis-namespace','~> 1.8.0'
gem 'redis-rails','~> 5.0.2'
gem 'redis-rack-cache','~> 2.2.1'


gem 'chartjs-ror','~> 3.6.4'

group :development do
 gem 'rack-mini-profiler','~> 2.2.1'
 gem 'memory_profiler','~> 1.0.0'
 gem 'flamegraph','~> 0.9.5'
 gem 'stackprof','~> 0.2.16'
end
gem 'blazer','~> 2.4.0'
gem 'ahoy_matey','~> 3.1.0'

gem 'groupdate','~> 5.2.1'
group :test, :development do
  gem 'rspec-rails', '~> 3.9.1'
  gem 'factory_bot_rails', '~> 5.1'
  gem 'capybara', '~> 3.29'

  #gem 'capybara', '~> 2.14.3'
  #gem 'database_cleaner', '~> 1.6.1'
  #gem "factory_bot_rails" '~> 6.1.0'
  #gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers', '~> 4.4.1'
    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'guard-rspec', '~> 4.7.3', require: false
  gem 'pry', '~> 0.13.1'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'selenium-webdriver', '~> 3.142.7'
end

group :test do
  gem 'vcr', '~> 6.0.0'
  gem 'database_cleaner', '~> 1.7'
  gem 'webmock', '~> 3.11.0'
  gem 'email_spec', '~> 2.2.0'
  gem 'rspec-sidekiq', '~> 3.1.0'
end


# group :production do
#   gem 'elastic-apm'
# end




gem 'aasm', '~> 5.1.1'
gem 'after_commit_everywhere', '~> 0.1', '>= 0.1.5'


gem 'will_paginate', '~> 3.3.0'
gem 'rake', '12.3.3'
# Use oracle as the database for Active Record
gem 'activerecord-oracle_enhanced-adapter' , '~> 5.2.8'
gem 'ruby-oci8', '~> 2.2.8' # only for CRuby users

gem "font-awesome-rails", '~> 4.7.0.5'
group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring','~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.0'

end
##
#gem 'mini_racer', platforms: :ruby


gem 'exception_notification', '~> 4.4.3'
gem 'wicked', '~> 1.3.4'
gem 'httparty', '~> 0.18.1'
gem "typhoeus", '~> 1.4.0'
gem "faraday", '~> 1.2.0'
gem "figaro", '~> 1.2.0'
gem 'dalli', '~> 2.7.11'
gem 'rolify', '~> 5.3.0'
gem 'pg_search', '~> 2.3.5'

gem 'sidekiq', '~> 5.2.9'
gem "sidekiq-cron", "~> 0.4.5"
gem 'sidekiq-failures', '~> 1.0.0'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap-generators', '~> 3.3.4'
gem 'devise', '~> 4.7.3'
gem 'devise_invitable', '~> 1.7.0'
gem 'state_machines-activerecord', '~> 0.6.0'
gem 'carrierwave', '~> 1.0'
gem 'cloudinary', '~> 1.18.1'


gem 'jquery-rails' , '~> 4.4.0'
gem 'jquery-ui-rails', '~> 6.0.1'


gem "tabs_on_rails", '~> 3.0.0'
gem "letter_opener", :group => :development
gem 'jquery-minicolors-rails'

group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger', '>= 0.1.1'
  gem 'capistrano-sidekiq'

  #gem 'capistrano-yarn'

  # Remove the following if your app does not use Rails
  gem 'capistrano-rails'

  # Remove the following if your server does not use RVM
  gem 'capistrano-rvm'
end