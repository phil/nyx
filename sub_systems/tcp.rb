class Tcp < Nyx::SubSystem
  
  attr_reader :connection
  def initialize *args
    @connection = EM.start_server "localhost", config.port, Tcp::Connection
  end

  class Connection < EM::Connection
    @@connected_clients = Array.new

    def post_init
      Nyx.log.debug "A client has connected..."

      message = Tcp::Message.new :type => "EnterMessage", :body => "Telnet session created"
      message.connection = self
      Nyx.message_manager.broadcast message
      
      @@connected_clients.push self
    end

    def unbind
      Nyx.log.debug "A client disconnected..."
      @@connected_clients.delete self
    end

    def receive_data data
      message = Tcp::Message.new
      message.body = data.strip
      message.connection = self
      Nyx.message_manager.broadcast message
    end

  end

  class Message < Nyx::Message
    attr_accessor :connection
    def reply text
      connection.send_data "#{text}\n"
    end
  end
    
end
