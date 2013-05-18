require_relative "sub_system_manager"

class Nyx
  class MessageManager

    attr_accessor :listeners

    def initialize
      self.listeners = Array.new
    end

    def broadcast message
      self.listeners.each do |listener|
        EM.next_tick { listener.process message }
      end
      yield if block_given?
    end

    def add_listener listener
      self.listeners.push listener
    end
    def add_listeners listeners
      self.listeners.push(*listeners)
    end

  end

  def message_manager
    @message_manager ||= MessageManager.new
  end

  def self.message_manager
    instance.message_manager
  end

end
