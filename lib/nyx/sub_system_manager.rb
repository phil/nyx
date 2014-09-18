class Nyx
  class SubSystemManager

    include Celluloid

    attr_accessor :linked_sub_systems

    def initialize
      self.linked_sub_systems ||= Array.new
    end

    def link_sub_systems
      Dir.glob(File.join("lib", "nyx", "sub_systems", "*")) do |dir|
        link_sub_system dir
      end
    end

    def link_sub_system dir

      name = File.basename(dir)
      file = File.join(dir, "#{name}.rb")

      puts "loading #{file}..."
      load file

      klass = File.basename(file, File.extname(file)).tableize.classify.constantize

      sub_system = klass.new_link
      # TODO: Add Listeners
      self.linked_sub_systems << sub_system
    end

    protected

  end

  def sub_system_manager
    @sub_system_manager ||= SubSystemManager.new_link
  end
end
