require 'singleton'
require 'active_support/all'

module Nyx
  class SubSystemManager

    include Singleton

    attr_accessor :installed_sub_systems
    #attr_accessor :listeners

    def initialize
      self.installed_sub_systems ||= Array.new
      #self.listeners ||= Array.new
    end

    def load_sub_systems

      Nyx::Log.info "Loading SubSystems"

      Dir.glob(File.join("sub_systems", "*.rb")) do |sub_system_file|

        Nyx::Log.info "Nyx::SubSystemManager loading subsystem '#{sub_system_file}'"
        if File.exists? sub_system_file
          Nyx::Log.info "Nyx::SubSystemManager loading subsystem '#{sub_system_file}'"
          self.load_sub_system sub_system_file
        end

      end

    end

    def load_sub_system sub_system_file, opts = Hash.new
      load sub_system_file
      sub_system = init_sub_system(sub_system_file)
      #Nyx::Log.info "Subsystem: #{sub_system.name}"
      #Nyx::Log.info "Listeners: #{sub_system.listeners.inspect}"
      #self.listeners += sub_system.listeners
      Nyx::MessageManager.add_listeners sub_system.listeners
      self.installed_sub_systems << sub_system
    end

    def init_sub_system sub_system_file
      sub_system_class(sub_system_file).new
    end

    def sub_system_class sub_system_file
      File.basename(sub_system_file, File.extname(sub_system_file)).classify.constantize
    end



    # Sends the incoming message to all 
    #def broadcast_incoming_message message
      #begin
        #self.listeners.each do |listener|
          #if [message.type, "AnyMessage"].include?(listener[:type]) && (matches = (message.body || "").match(listener[:pattern]))
            #EM.next_tick do
              #message_for_listener = message.clone
              #listener[:handler].call message
            #end
          #end
        #end
      #rescue Exception => e
        #Nyx::Log.error "Failed sending message #{message}: #{e.message} #{e.backtrace}"
      #end
    #end

    #def broadcast_outgoing_message message
    #end

    #def send_message message

    #end

    def self.installed sub_system
      Nyx::SubSystemManager.instance.installed_sub_systems.detect { |sys| sys.name == sub_system }
    end

    def self.sub_systems
      Nyx::SubSystemManager.instance.installed_sub_systems
    end

  end
end
