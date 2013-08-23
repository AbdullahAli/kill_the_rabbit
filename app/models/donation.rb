require 'queuer'
class Donation < ActiveRecord::Base
  include Queuer

  after_commit :enqueue

  def process
    puts "procssing donationnnnnnnnnnnnnnnn"
  end
end
