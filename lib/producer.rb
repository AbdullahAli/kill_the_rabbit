class Producer

  def self.receive_from_resque(klass, id, msg)
    puts "receive_from_resque #{klass}, #{id}, #{msg}"
    publish(klass, id, msg)
  end

  def self.publish(klass, id, msg)
    puts "tying to publish"
    conn = Bunny.new
    conn.start
    ch = conn.create_channel

    queueue = "#{klass}_#{msg}"
    puts "qu #{queueue}"

    q = ch.queue(queueue)
    puts "q #{q.inspect}"


    puts "def #{ch.default_exchange.inspect}"
    ch.default_exchange.publish(id.to_s, :routing_key => q.name)
    puts "published"

    conn.close
  end

end

