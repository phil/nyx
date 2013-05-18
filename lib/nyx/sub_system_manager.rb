require 'active_support/all'

class Nyx
  class SubSystemManager

    attr_accessor :installed_sub_systems

    def initialize
      self.installed_sub_systems ||= Array.new
    end

    def load_sub_systems

      Nyx.log.info "Loading SubSystems"

      Dir.glob(File.join("sub_systems", "*.rb")) do |sub_system_file|

        Nyx.log.info "Nyx::SubSystemManager loading subsystem '#{sub_system_file}'"
        if File.exists? sub_system_file
          Nyx.log.info "Nyx::SubSystemManager loading subsystem '#{sub_system_file}'"
          self.load_sub_system sub_system_file
        end

      end

    end

    def load_sub_system sub_system_file, opts = Hash.new
      load sub_system_file
      sub_system = init_sub_system(sub_system_file)
      Nyx.message_manager.add_listeners sub_system.listeners
      self.installed_sub_systems << sub_system
    end

    def init_sub_system sub_system_file
      sub_system_class(sub_system_file).new
    end

    def sub_system_class sub_system_file
      File.basename(sub_system_file, File.extname(sub_system_file)).tableize.classify.constantize
    end

    def installed sub_system
      installed_sub_systems.detect { |sys| sys.name == sub_system }
    end

    def sub_systems
      installed_sub_systems
    end

  end

  def sub_system_manager
    @sub_system_manager ||= SubSystemManager.new
  end
  def self.sub_system_manager
    instance.sub_system_manager
  end
end
