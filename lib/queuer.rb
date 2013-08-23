module Queuer
  def enqueue
    puts "in enque"
    if try_count_field == 0
      puts "ensuingggg"
      Resque.enqueue(RequestReceived, self.id)
    else
      Resque.enqueue_in(retry_phase, RequestReceived, self.id)
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
