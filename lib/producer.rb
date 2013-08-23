class Producer

  def self.receive_from_resque(klass, id, msg)
    puts "receive_from_resque #{klass}, #{id}, #{msg}"
    publish(klass, id, msg)
  end

  def self.publish(klass, id, msg)
    conn = Bunny.new
    conn.start

    ch       = conn.create_channel
    x        = ch.topic("topic_logs")
    severity = "#{klass}.process"
    msg      = "#{id}"

    x.publish(msg, :routing_key => severity)
    puts " [x] Sent #{severity}:#{msg}"

    conn.close
  end
end
