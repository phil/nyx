class Nyx
  class SubSystemManager

    include Celluloid
    trap_exit :sub_system_crashed

    attr_reader :linked_sub_systems

    def initialize
      @linked_sub_systems ||= Array.new
    end

    def link_sub_systems
      Dir.glob(File.join("lib", "nyx", "sub_systems", "*")) do |dir|
        Actor.current.async.link_sub_system dir
      end
    end

    def link_sub_system dir

      name = File.basename(dir)
      file = File.join(dir, "#{name}.rb")

      puts "loading #{file}..."
      require File.join(Nyx.env.root, file)

      klass = File.basename(file, File.extname(file)).tableize.classify.constantize

      sub_system = klass.new_link
      Actor["nyx"].message_manager.add_listeners sub_system.listeners
      self.linked_sub_systems << sub_system
    end

    protected

    def sub_system_crashed sub_system, reason
      puts "SUBSYSTEM CRASHED: #{sub_system}"
      puts "                   #{reason}"
    end

  end

  def sub_system_manager
    @sub_system_manager ||= SubSystemManager.new_link
  end
end
