class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :runner_id
      t.integer :result, :limit => 8

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
