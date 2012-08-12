require 'singleton'
require 'em-hiredis'


module Nyx
  class Memory

    include Singleton

    attr_accessor :redis

    def initialize *args
    end

    def redis
      @redis ||= EM::Hiredis.connect
      select_database ::NYX_ENV
      @redis
    end

    def select_database env = "development"
      database_id = case env
                    when "test"
                      2
                    when "production"
                      1
                    else
                      # default to development
                      0
                    end
      @redis.select(database_id)
    end

    def self.connected?
      self.instance.redis.connected?
    end

    def self.ping
      self.instance.redis.ping.callback do |pong|
        yield pong
      end
    end

    def self.set keys_and_values = Hash.new
      keys_and_values = keys_and_values.to_a.flatten
      self.instance.redis.mset(*keys_and_values) do
        yield 
      end
    end

    def self.get *keys
      self.instance.redis.mget(*keys) do |values|
        keys_and_values = Hash.new
        values.each_with_index do |value,index|
          keys_and_values[keys[index]] = value
        end
        yield keys_and_values
      end
    end

  end
end
