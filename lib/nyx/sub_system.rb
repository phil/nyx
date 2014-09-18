#require_relative "../lib/nyx/sub_system"
#require_relative "../lib/nyx/message"

class Nyx
  module SubSystem

    extend ActiveSupport::Concern

    included do
      include Celluloid
      finalizer :finalize
    end

    def finalize
      # Override in SubSystem
    end

    module ClassMethods
    end
  end
end
