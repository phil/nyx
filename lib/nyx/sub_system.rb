#require_relative "../lib/nyx/sub_system"
#require_relative "listener"

class Nyx
  class SubSystem

    #included do
    include Celluloid
    finalizer :finalize

    def initialize
      puts "Init: #{listeners.inspect}"
    end

    def finalize
      # Override in SubSystem
    end

    def name
      self.class.to_s.underscore.to_sym
    end

    def tag
      self.class.to_s.underscore.to_sym
    end

    def description
      # Override in sub classes
      "No description provided"
    end

    # Setup listeners accessor on the metaclass
    # This ensures listeners won't leak into other subsystems
    class << self; attr_accessor :listeners; end

    def listeners
      return Array.new if wrapped_object.class.listeners.nil? || wrapped_object.class.listeners.empty?
      #puts Actor.current.methods.sort
      #puts Actor.current.method(:ping).inspect
      wrapped_object.class.listeners.map do |listener|

        listener.method_handler = Actor.current.method(listener.method_symbol) if listener.method_symbol
        listener
      end
    end

    def self.listen_for regex, method_symbol = nil, &block
      self.listeners ||= Array.new

      regex = {"AnyMessage" => regex} if regex.is_a?(Regexp)
      regex.each do |k,v|
        # k is "AnyMessage", "EnterMessage"
        # v is the regex

        # self.listeners is the class instance variable accessor
        #listener = Listener.new({:type => k, :pattern => v, :method_tag => method_tag, :block => block})

        listener = Listener.new
        listener.type = k
        listener.pattern = v
        listener.method_symbol = method_symbol
        listener.block_handler = block

        self.listeners << listener
      end
    end

  end
end
