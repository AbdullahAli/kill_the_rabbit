require "bunny"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

conn = Bunny.new
conn.start

ch  = conn.create_channel
x   = ch.topic("topic_logs")
q   = ch.queue("", :exclusive => true)

q.bind(x, :routing_key => "donation.process")

puts " [*] Waiting for logs. To exit press CTRL+C"

begin
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts body
    puts "Donation process consumer"
    puts " [y] #{delivery_info.routing_key}:#{body}"
    Donation.find_by_id(body).process
  end
rescue Interrupt => _
  ch.close
  conn.close
end