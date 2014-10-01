class Nyx
  class Listener

    #include Celluloid

    attr_accessor :type
    attr_accessor :pattern
    attr_accessor :method_symbol

    attr_accessor :block_handler
    attr_accessor :method_handler

    def method_handler?
      method_handler != nil
    end

    def process message
      puts "process: #{message}"
      if type_match_for_message(message) && (matches = pattern_matches_for_message(message))
        puts "calling handler"
        call message, matches
      end
    end

    def call message, matches = nil
      case handler.arity
      when 1
        handler.call message
      when 2
        handler.call message, matches
      end
    end

    def handler
      if method_handler?
        method_handler
      else
        block_handler
      end
    end

    def type_match_for_message message
      type == "AnyMessage" || message.type == self.type
    end

    def pattern_matches_for_message message
      (message.body || "").match(pattern)
    end

  end
end
