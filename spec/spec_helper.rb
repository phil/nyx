require 'simplecov'
SimpleCov.start

require 'rubygems'
require_relative "../config/environment"
ENV["NYX_ENV"] ||= 'test'

RSpec.configure do |config|
  # == Mock Framework
  #config.mock_with :rspec
end
