require 'em-mongo'
require_relative 'configurator'

class Nyx
  class Memory

    attr_accessor :connection

    def connection
      @connection ||= EM::Mongo::Connection.new(config.host).db(config.database)
    end

    #def collection name
      #connection.collection("name")
    #end

    def config
      @config ||= Nyx::Configurator.new :mongo
    end
  end

  attr_accessor :memory

  def self.memory
    instance.memory ||= Nyx::Memory.new
  end

end
