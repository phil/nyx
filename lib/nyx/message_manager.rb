#require_relative "sub_system_manager"

class Nyx
  class MessageManager

    include Celluloid

    attr_reader :listeners

    def initialize
      @listeners = Array.new
    end

    def broadcast message
      #self.listeners.each do |listener|
      #end
      #@listeners.each do |listener|
        #EM.next_tick { listener.process message }
      #end
      #yield if block_given?
    end

    def add_listener listener
      @listeners.push listener
    end

    def add_listeners listeners
      puts "Adding Listeners: #{listeners.inspect}"
      @listeners.push(*listeners)
    end

  end

  def message_manager
    @message_manager ||= MessageManager.new_link
  end

end
