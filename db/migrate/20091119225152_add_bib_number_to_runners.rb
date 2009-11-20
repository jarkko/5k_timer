class AddBibNumberToRunners < ActiveRecord::Migration
  def self.up
    add_column :runners, :bib_number, :integer
    add_index :runners, [:bib_number], :unique => true
  end

  def self.down
    remove_index :runners, :column => [:bib_number]
    remove_column :runners, :bib_number
  end
end
