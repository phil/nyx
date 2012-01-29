require 'singleton'

class Nyx::Log

	include Singleton

	attr_accessor :logger

	def initialize *args
		#self.logger = Logger.new(File.join(THE_ROOT_OF_NYX, "log/nyx.log"))
		self.logger = Logger.new STDOUT
		self.logger.level = Logger::DEBUG
	end

	# FATAL an unhandleable error that results in a program crash
	def self.fatal message
		Nyx::Log.instance.logger.fatal message
	end

	# ERROR a handleable error condition
	def self.error message
		Nyx::Log.instance.logger.error message
	end

	# WARN a warning
	def self.warn message
		Nyx::Log.instance.logger.warn message
	end

	# INFO generic (useful) information about system operation
	def self.info message
		Nyx::Log.instance.logger.info message
	end

	# DEBUG low-level information for developers
	def self.debug message
		Nyx::Log.instance.logger.debug message
	end


end