class AddColumnUserIdToUserCategoris < ActiveRecord::Migration
  def self.up
    add_column :user_categories, :user_id, :integer
  end

  def self.down
  end
end
