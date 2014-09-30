class Nyx
  include Celluloid

require_relative "nyx/env"
#require_relative "nyx/configurator"
#require_relative "nyx/log"
#require_relative "nyx/memory"
require_relative "nyx/listener"
require_relative "nyx/message"
require_relative "nyx/message_manager"
require_relative "nyx/sub_system"
require_relative "nyx/sub_system_manager"

  def initialize
    sub_system_manager.link_sub_systems
  end

end

