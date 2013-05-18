class MessageStore < Nyx::SubSystem
  
  listen_for /(.*)/ do |message|
    Nyx.memory.collection("messages").safe_insert(message.to_h)
  end

end
