class Tcp < Nyx::SubSystem
  
  attr_reader :connection
  def initialize *args
    @connection = EM.start_server "localhost", 5005, Tcp::Connection
  end

  class Connection < EM::Connection
    @@connected_clients = Array.new

    def post_init
      Nyx::Log.debug "A client has connected..."
      @@connected_clients.push self
    end

    def unbind
      Nyx::Log.debug "A client disconnected..."
      @@connected_clients.delete self
    end

    def receive_data data
      Nyx::Log.debug "#{data.strip}"
      message = Tcp::Message.new
      message.body = data.strip
      message.connection = self
      Nyx::MessageManager.broadcast message
    end
  end

  class Message < Nyx::Message
    attr_accessor :connection
    def reply text
      connection.send_data "#{text}\n"
    end
  end
    
end
