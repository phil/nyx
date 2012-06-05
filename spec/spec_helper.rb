require 'simplecov'
SimpleCov.start

ENV["NYX_ENV"] ||= 'test'
puts "Spec Hlepr"

#Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  config.mock_with :rspec
end
