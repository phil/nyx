require "singleton"
require_relative "sub_system_manager"

module Nyx
  class MessageManager

    include Singleton

    attr_accessor :listeners

    def initialize
      self.listeners = Array.new
    end

    def self.broadcast message
      self.listeners.each do |listener|
        EM.next_tick { listener.process message }
      end
      yield if block_given?
    end

    def self.add_listener listener
      self.instance.listeners << listener
    end
    def self.add_listeners listeners
      listeners.each do |listener|
        add_listener listener
      end
    end
    def self.listeners
      self.instance.listeners
    end

  end
end
