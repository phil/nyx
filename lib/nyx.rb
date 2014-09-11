require 'singleton'

class Nyx
  include Singleton
end

puts "requiring nyx"
require_relative "nyx/env"
require_relative "nyx/configurator"
require_relative "nyx/log"
require_relative "nyx/memory"
require_relative "nyx/message"
require_relative "nyx/message_manager"
require_relative "nyx/sub_system"
require_relative "nyx/sub_system_manager"
