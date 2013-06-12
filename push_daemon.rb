require './worker'
require './udp_server'
require './jobs'
require './client'

class PushDaemon
  def initialize
    @worker = Worker.new
    @server = UDPServer.new(self)
  end

  def start
    @worker.spawn(10)
    @server.listen(6889)
  end

  def call(client, message)
    job = Jobs.factory(client, message)

    if job
      @worker << job
    end
  end
end

