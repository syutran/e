class AddColumnUserCategoryIdToRules < ActiveRecord::Migration
  def self.up
    add_column :rules, :user_category_id, :integer
  end

  def self.down
  end
end
