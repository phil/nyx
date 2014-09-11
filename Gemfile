source "https://rubygems.org"

gem "eventmachine"
#gem "java", :group => [:production]
gem "em-hiredis" # Non Blocking Redis for Eventmachine
gem "em-http-request"
#gem "bson_ext"
gem "em-mongo"

gem "tinder" # Campfire

gem "sinatra"
gem "thin"

gem "heroku"

# Process Management
gem "foreman"

# Performance Management
gem "newrelic_rpm", :group => :production

# Extras
gem "activesupport", "4.0.0", :require => "active_support/all"
gem "i18n"

# Testing
group :test, :development do
  gem "rspec"
  gem "capybara"

  gem "em-spec" # https://github.com/schmurfy/em-spec

  gem "simplecov", :require => false
end
