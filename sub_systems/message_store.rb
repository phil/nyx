class MessageStore < Nyx::SubSystem
  
  listen_for /(.*)/ do |message|
    #Nyx.memory.collection("messages").safe_insert(message.to_h)
    puts "storing message: #{message.to_h}"
    Nyx.memory.connection.collection("messages").safe_insert(message.to_h)
  end

end
