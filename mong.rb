require 'em-mongo'
require 'eventmachine'

EM.run do
  db = EM::Mongo::Connection.new('localhost').db('my_database')
  collection = db.collection('my_collection')

  i = 0

  EM.next_tick do
    puts i
    i+=1
  end

  EM.add_periodic_timer(5) { EM.stop }
end
