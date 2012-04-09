require "bundler/setup"

begin
	THE_NUMBER_OF_NYX = ARGV[ARGV.index("-p") + 1] # Get Port number from command line
rescue
	THE_NUMBER_OF_NYX = 5000
end
puts "NYX Port: #{THE_NUMBER_OF_NYX}"

THE_ROOT_OF_NYX = File.expand_path("#{__FILE__}/../../")
puts "NYX Root: #{THE_ROOT_OF_NYX}"

#ENV['BUNDLE_GEMFILE'] = File.expand_path("Gemfile")
#Bundler.setup
Bundler.require(:default) if defined?(Bundler)
#Bundler.require(:default, (@env || "development")) if defined?(Bundler) # For loading developemnt gems

require File.join(THE_ROOT_OF_NYX, "lib", "nyx")

# Need to fix a few acvtivesupport infections
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
	inflect.singular 'status', 'status'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
end
