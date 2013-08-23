class LogRequest
  @queue = :log_request

  def self.perform(meta)
    puts "LogRequest some meta: #{meta.inspect}"
  end

end
