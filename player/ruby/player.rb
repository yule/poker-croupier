$:.push('../gen-rb')

require_relative '../../vendor/bundle/ruby/1.9.1/gems/thrift-0.9.1/lib/thrift'
require 'player'

class PlayerHandler
  def newGame
    puts "New Game"
  end
end

def create_service(handler)
  server = create_server(handler)

  puts "Starting the server..."

  server.serve()
end

def create_server(handler)
  processor = Player::Processor.new(handler)
  transport = Thrift::ServerSocket.new(9090)
  transportFactory = Thrift::BufferedTransportFactory.new()
  Thrift::ThreadPoolServer.new(processor, transport, transportFactory)
end

create_service(PlayerHandler)