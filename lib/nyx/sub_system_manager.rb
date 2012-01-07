require 'singleton'

class Nyx::SubSystemManager
	
	include Singleton
	
	attr_accessor :installed_sub_systems

	def initialize
		self.installed_sub_systems ||= Array.new
	end
	
	def load_sub_systems
		
		Dir.glob(File.join("**", "sub_systems", "*")) do |sub_system_dir|
			
			puts File.expand_path(sub_system_dir)
			
			sub_system_file = File.join File.expand_path(sub_system_dir), File.basename(sub_system_dir) + ".rb"
			puts sub_system_file
			
			if File.exists? sub_system_file
				self.load_sub_system sub_system_file#, :setup_watcher => true
			end
			
		end
		
	end
	
	def load_sub_system sub_system_file, opts = Hash.new
		#opts[:setup_watcher] ||= true
		load sub_system_file
		
		self.installed_sub_systems << File.basename(sub_system_file, File.extname(sub_system_file)).classify.constantize.new
		
		#EM.watch_file sub_system_file, BigRainbowHead::SubSystemFileWatch if opts[:setup_watcher]
	end
	
end