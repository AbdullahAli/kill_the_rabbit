require "bunny"

conn = Bunny.new
conn.start

ch = conn.create_channel

q = ch.queue("#")

begin
  puts "----------------"
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] greddy consumer Received #{body}"
    # donation = Donation.find(body)
    # donation.process
  end
rescue Interrupt => _
  conn.close
  exit(0)
end
