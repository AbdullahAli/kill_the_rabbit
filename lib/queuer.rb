module Queuer

  def enqueue
    puts "Will enqueue #{self.id} in #{retry_phase}"
    if retry_phase
      Resque.enqueue_in(retry_phase, RequestReceived, self.id)
    else
      puts "Too many retries"
    end
  rescue Exception => e
    Rails.logger.debug e.message
  end

  def retry_phase
    retry_policy[try_count_field-1]
  end

  def retry_policy
    [10.seconds, 20.seconds, 1.minute]
  end
end
