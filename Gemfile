source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in spree-seo.gemspec.
gemspec

gem "rails", "~> 7.1.0"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
# gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
gem 'rack', "~> 2.0"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"
gem "aws-sdk-s3", require: false

gem 'spree'
gem 'spree_backend'
gem 'spree_gateway'
gem 'spree_przelewy24', github: 'cloudsailor/spree_przelewy24', branch: 'release-1.1.0'
gem 'spree_i18n'
gem 'spree_auth_devise', github: 'cloudsailor/spree_auth_devise', branch: 'main'
gem 'spree_emails'
gem 'sneakers'

gem 'searchkick'
gem 'spree_searchkick', github: 'FG-IT/spree_searchkick', branch: 'ibspot'
gem 'elasticsearch', ' ~> 7.17'
# sidekiq
gem 'sidekiq'

gem 'deface'

gem 'money-rails'
gem 'bunny'

# improved JSON rendering performance
gem 'oj'

gem 'sassc', github: 'sass/sassc-ruby', branch: 'master'
gem 'exception_notification', git: 'https://github.com/smartinez87/exception_notification.git', ref: 'master'

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
end

group :development do
  # monitoring
  gem "web-console"
  gem 'bullet'
  gem 'rack-mini-profiler', require: false
end
