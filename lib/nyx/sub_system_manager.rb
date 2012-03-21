require 'singleton'

class Nyx::SubSystemManager

  include Singleton

  attr_accessor :installed_sub_systems

  def initialize
    self.installed_sub_systems ||= Array.new
  end

  def load_sub_systems

    Dir.glob(File.join("**", "sub_systems", "*")) do |sub_system_dir|

      sub_system_file = File.join File.expand_path(sub_system_dir), File.basename(sub_system_dir) + ".rb"

      if File.exists? sub_system_file
        Nyx::Log.info "Nyx::SubSystemManager loading subsystem '#{sub_system_file}'"
        self.load_sub_system sub_system_file
      end

    end

  end

  def load_sub_system sub_system_file, opts = Hash.new
    load sub_system_file
    self.installed_sub_systems << File.basename(sub_system_file, File.extname(sub_system_file)).classify.constantize.new
  end


  # Sends the incoming message to all 
  def broadcast_incoming_message message
    # Let all the subsystems know about it
    installed_sub_systems.each do |sub_system|
      EM.next_tick do
        sub_system.incoming_message(message)
      end
    end
  end

  def broadcast_outgoing_message message

  end

  def send_message message

  end

  def self.installed sub_system
    Nyx::SubSystemManager.instance.installed_sub_systems.detect { |sys| sys.name == sub_system }
  end

end
