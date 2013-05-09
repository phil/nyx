class MessageStore < Nyx::SubSystem
  
  listen_for /(.*)/ do |message|
    db = EM::Mongo::Connection.new('localhost').db('nyx_development')
    messages = db.collection("messages")
    messages.safe_insert(message.to_h)
  end

end
