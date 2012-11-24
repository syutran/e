class AddColumnUserCategoryIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :user_category_id, :integer
  end

  def self.down
  end
end
