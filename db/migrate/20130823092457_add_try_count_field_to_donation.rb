class AddTryCountFieldToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :try_count_field, :integer, :default => 0
  end
end
