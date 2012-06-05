require 'active_support/all'

module Nyx
  class SubSystem

    # Override in subsystem for init
    def initialize *args
    end

    # Override in subsystem 
    def finalize
    end

    # Used to identify the sub system at runtime
    def name
      self.class.to_s.underscore.to_sym
    end

    def tag
      self.class.to_s.underscore.to_sym
    end

    def status
      Hash.new
    end

    def self.metaclass
      class << self
        self
      end
    end
    def self.meta_eval &blk; metaclass.instance_eval &blk; end

    meta_eval do attr_accessor :commands; end
    def self.command command, description = "", &block
      self.commands ||= Hash.new
      self.commands[command] = description

      define_method command do
        puts "Command #{command}"
        block.call
      end

    end

    # Class instance variable.
    class << self; attr_accessor :listeners; end
    @listeners ||= Array.new

    def listeners

      #raise self.class.listeners.keys.inspect
      #raise self.class.listeners.inspect
      return Array.new if self.class.listeners.nil? || self.class.listeners.empty?
      self.class.listeners.collect do |hash|
        #raise listeners.inspect
        hash[:handler] = if hash[:method_tag]
                    self.method(hash[:method_tag]) 
                  else
                    hash[:block]
                  end
                      
        hash
      end
    end

    protected
    def self.listen_for regex, method_tag = nil, &block
      
      # could be a simple regex, or a hash {"EnterMessage" => /regex/}
      #if regex is just a regex, then convert it to a hash
      regex = {"AnyMessage" => regex} if regex.is_a?(Regexp)

      self.listeners ||= Array.new

      regex.each do |k,v|
        # k is "AnyMessage", "EnterMessage"
        # v is the regex

        # self.listeners is the class instance variable accessor
        self.listeners << {:type => k, :pattern => v, :method_tag => method_tag, :block => block}
      end

    end
    public

  end
end
