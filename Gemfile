source 'https://rubygems.org'

# Server requirements
gem 'thin', '~> 1.7.0'

# Project requirements
gem 'rake', '~> 13.0'

# Component requirements
gem 'erubis', '~> 2.7.0'
gem 'activerecord', '~> 6.1', :require => 'active_record'
gem 'sqlite3', '~> 1.4'

group :development do
  gem 'better_errors', '~> 2.4'
end

# Test requirements
group :test do
  gem 'rspec' , '~> 3.6'
  gem 'factory_bot', '~> 4.8.2'
  gem 'rack-test', '~> 1.0', require: 'rack/test'
end

# Automatically running tests
gem 'guard-rspec', '~> 4.7', require: false
gem 'libnotify', '0.9.3'

# Security
gem 'bcrypt', '~> 3.1.11'

# Padrino Stable Gem
gem 'wirble', '0.1.3'
gem 'pry', '~> 0.11'
gem 'tilt', '~> 2.0.7'

# Padrino edge
#gem 'padrino', :git => "git://github.com/padrino/padrino-framework.git"
gem 'padrino', '0.15.1'

gem 'redcarpet', '~> 3.5'


# Codecoverage tools
# gem 'simplecov'
# gem 'metric_fu'
gem 'coveralls', require: false
