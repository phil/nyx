#require_relative "sub_system_manager"

class Nyx
  class MessageManager

    include Celluloid

    attr_reader :listeners

    def initialize
      @listeners = Array.new
    end

    def broadcast message
      puts "Listeners: #{listeners.inspect}"
      @listeners.each do |listener|
        puts "broadcasting to #{listener}"
        listener.process message
      end
    end

    def add_listener listener
      @listeners.push listener
    end

    def add_listeners listeners
      puts "MessageManager: #{object_id}"
      puts "Adding Listeners: #{listeners.inspect}"
      @listeners.push(*listeners)
    end

  end

  def message_manager
    Actor[:message_manager]
  end

end
