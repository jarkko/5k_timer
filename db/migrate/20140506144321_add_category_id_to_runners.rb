class AddCategoryIdToRunners < ActiveRecord::Migration
  def self.up
    add_column :runners, :category_id, :integer
  end

  def self.down
    remove_column :runners, :category_id
  end
end
