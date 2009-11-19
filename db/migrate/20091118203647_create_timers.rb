class CreateTimers < ActiveRecord::Migration
  def self.up
    create_table :timers do |t|
      t.integer :start_time

      t.timestamps
    end
  end

  def self.down
    drop_table :timers
  end
end
