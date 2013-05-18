require 'em-mongo'
require 'yaml'
#require_relative 'env'

class Nyx
  class Memory

    attr_accessor :connection

    def connection
      @connection ||= EM::Mongo::Connection.new('localhost').db("nyx_#{Nyx.env}")
    end

    def collection name
      connection.collection("name")
    end

  end

  attr_accessor :memory

  def self.memory
    instance.memory ||= Nyx::Memory.new
  end

end
