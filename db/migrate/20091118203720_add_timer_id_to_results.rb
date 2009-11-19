class AddTimerIdToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :timer_id, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column :results, :timer_id
  end
end
