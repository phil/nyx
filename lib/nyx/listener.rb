require 'ostruct'

class Nyx
  class Listener

    attr_accessor :type
    attr_accessor :pattern
    attr_accessor :method_symbol

    attr_accessor :block_handler
    attr_accessor :method_handler
    def method_handler?
      self.method_handler != nil
    end

    def process message
      if type_match_for_message(message) && (matches = pattern_matches_for_message(message))
        call message, matches
      end
    end

    def call message, matches = nil
      if self.method_handler?
        self.method_handler.call message
      else
        self.block_handler.call message
      end
    end

    def type_match_for_message message
      self.type == "AnyMessage" || message.type == self.type
    end

    def pattern_matches_for_message message
      (message.body || "").match(self.pattern)
    end

  end
end
