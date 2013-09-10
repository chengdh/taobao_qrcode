require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
#source 'https://rubygems.org'
source 'http://ruby.taobao.org'

case HOST_OS
  when /darwin/i
    gem 'rb-fsevent', :group => :development
    gem 'growl', :group => :development
  when /linux/i
    gem 'libnotify', :group => :development
    gem 'rb-inotify', :group => :development
  when /mswin|windows/i
    gem 'rb-fchange', :group => :development
    gem 'win32console', :group => :development
    gem 'rb-notifu', :group => :development
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use mysql as the database for Active Record
gem 'mysql2',"~> 0.3.13"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails',"~> 3.0.4"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks',"~> 1.3.0"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder',"~> 1.5.1"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc',"~> 0.3.20",require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn',"~> 4.6.3"

# Use Capistrano for deployment
gem 'capistrano',"~> 2.15.5", group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
# Miscellanea
# gem 'google-analytics-rails'
gem 'haml-rails', "~> 0.4"
gem "rqrcode", "~> 0.4.2"
# gem 'http_accept_language'
gem 'nokogiri', "~> 1.6.0"
# gem 'resque', require: 'resque/server' # Resque web interface

# Assets
gem 'haml_assets', "~> 0.2.2"
# gem 'handlebars_assets'
gem 'i18n-js', "~> 2.1.2"
gem 'jquery-turbolinks',"~> 2.0.1"
gem 'less-rails', "~> 2.4.0"
gem 'therubyracer', "~> 0.12.0"
gem 'twitter-bootstrap-rails', github: 'diowa/twitter-bootstrap-rails', branch: 'fontawesome-3.2.1'

#taobaoSDK
#NOTE 先在本地安装
gem 'taobaoSDK',path: "~/myproject/taobaoSDK"
gem "will_paginate", "~> 3.0.4"
gem "will_paginate-bootstrap", "~> 0.2.4"
gem "fancybox2-rails", "~> 0.2.4"


group :development, :test do
  gem 'debugger', "~> 1.6.1"
  gem 'delorean', "~> 2.1.0"
  gem 'factory_girl_rails', "~> 4.2.1"
  gem 'faker', "~> 1.2.0"
  gem 'pry-rails', "~> 0.3.2"
  gem 'awesome_print', "~> 1.1.0"
  gem 'rspec-rails', "~> 2.14.0"
end

group :development do
  gem 'bullet', "~> 4.6.0"
  gem 'better_errors'
  gem 'binding_of_caller', "~> 0.7.2"
  gem 'meta_request', "~> 0.2.8"
  gem "rails-footnotes",'~> 3.7.8'
  #gem 'guard-rails_best_practices'
end

group :test do
  gem 'capybara', "~> 2.1.0"
  gem 'coveralls', "~> 0.6.7", require: false
  gem 'database_cleaner', "~> 1.1.1"
  gem 'email_spec',"~> 1.5.0"
  gem 'launchy', "~> 2.3.0"
  gem 'selenium-webdriver', "~> 2.35.1"
  gem 'simplecov', "~> 0.7.1", require: false
  gem 'webmock', "~> 1.13.0", require: false
  gem 'spork-rails', :github => 'sporkrb/spork-rails' 
  gem 'guard-spork'
  gem "guard-rspec", "~> 3.0.2"
  gem 'guard-livereload', "~> 1.4.0"
  gem 'guard-bundler',"~> 1.0.0"
end

group :staging, :production do
  gem 'rails_12factor', "~> 0.0.2"
end
