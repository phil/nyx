require "bundler/setup"
require_relative "../lib/nyx/env"


#ENV['BUNDLE_GEMFILE'] = File.expand_path("Gemfile")
#Bundler.setup
Bundler.require(:default) if defined?(Bundler)
#Bundler.require(:default, (@env || "development")) if defined?(Bundler) # For loading developemnt gems


# Nyx Libs
require File.join(Nyx::Env.root, "lib", "nyx", "log")
require File.join(Nyx::Env.root, "lib", "nyx", "memory")
require File.join(Nyx::Env.root, "lib", "nyx", "message")
require File.join(Nyx::Env.root, "lib", "nyx", "message_manager")
require File.join(Nyx::Env.root, "lib", "nyx", "sub_system")
require File.join(Nyx::Env.root, "lib", "nyx", "sub_system_manager")

# Nyx Web interface
require File.join(Nyx::Env.root, "web", "web")

# Need to fix a few acvtivesupport infections
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
	inflect.singular 'status', 'status'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
end
