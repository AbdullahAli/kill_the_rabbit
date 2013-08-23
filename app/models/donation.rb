require 'queuer'
require 'producer'

class Donation < ActiveRecord::Base
  include Queuer

  after_commit :enqueue_to_rabbit, :on => :create

  def process
    update_attribute(:try_count_field, try_count_field+1)
    enqueue
  end

  def enqueue_to_rabbit
    Producer.publish(self.class.to_s.downcase, self.id, "process")
  end
end
