require_relative "../lib/nyx/sub_system"
require File.join(Nyx.root, "web", "web")

class Web < Nyx::SubSystem
    
end

NyxWebInterface.run! :port => 5007
