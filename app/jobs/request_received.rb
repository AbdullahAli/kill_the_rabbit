require 'producer'

class RequestReceived
  @queue = :request_received

  def self.perform(id)
    puts "RequestReceived some meta: #{id.inspect}"

    Producer.receive_from_resque("donation", id, "process")
    puts "called producer by now"

  end

end
