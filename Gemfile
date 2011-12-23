source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'aasm'
gem 'acts_as_list'
gem 'thin'
gem 'devise', '~> 2.0.0.rc'
gem 'will_paginate', '~> 3.0'
gem 'prototype-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

# gem 'jquery-rails'

group :development, :test do
  gem 'ruby-debug19', :require => 'ruby-debug'
  # gem 'guard', '0.8.8'
  # gem 'guard-test', '0.4.2'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl'
  # gem 'ruby-prof'
end

platforms :ruby do
  gem 'rb-readline'
end

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

