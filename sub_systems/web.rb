require_relative "../lib/nyx/sub_system"
require File.join(Nyx.root, "web", "web")

class Web < Nyx::SubSystem

  def initialize
    NyxWebInterface.run! :port => config.port
  end

end

