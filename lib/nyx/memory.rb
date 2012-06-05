require 'singleton'
require 'em-hiredis'

module Nyx
  class Memory

    include Singleton
    
    attr_accessor :redis

    def initialise *args
    end

    def redis
      @redis ||= EM::Hiredis.connect
      #select_database NYX_ENV
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
     redis.select(database_id)
    end

    #def self.store *args

      #EM.next_tick do
        #self.instance.foo = "wow"
      #end
    #end

    #def self.retrieve keys, &block
     #my_var = self.instance.foo
     #EM.next_tick do
       #block.call my_var
     #end
     ##"meh"
    #end

    def self.set hash
      self.instance.redis.set('foo', 'bar').callback do
        yield 
      end
    end

    def self.get key
      self.instance.redis.get(key) do |value|
        Nyx::Log.info "getting '#{key}: #{value}"
        yield value
      end
    end

  end
end
