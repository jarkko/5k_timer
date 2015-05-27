class AddBibNumberToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :bib_number, :string
  end

  def self.down
    remove_column :results, :bib_number
  end
end