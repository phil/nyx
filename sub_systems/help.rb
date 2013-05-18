require_relative "../lib/nyx/sub_system"

class Help < Nyx::SubSystem

  listen_for /^help|info$/i do |message|
    sub_systems_help = Hash.new
    Nyx.sub_system_manager.installed_sub_systems.each do |sub_system|
      sub_systems_help[sub_system.tag] = sub_system.description
      sub_systems_help[sub_system.tag] << sub_system.listeners.collect{ |listener| listener.pattern.to_s }.join("\n")
    end
    message.reply sub_systems_help.collect{ |k,v| [k, [*v].join("\n")].join("\n") }.join("\n\n")
  end

  def description
    "Provides help for subsystem"
  end

end
