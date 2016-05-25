#require_relative "sub_system_manager"

class Nyx
  class MessageManager

    include Celluloid

    attr_reader :listeners

    def initialize
      @listeners = Array.new
    end

    def broadcast message
      @listeners.each do |listener|
        listener.process message
      end
    end

    def add_listener listener
      @listeners.push listener
    end

    def add_listeners listeners
      @listeners.push(*listeners)
    end

  end

  def message_manager
    Actor[:message_manager]
  end

end
