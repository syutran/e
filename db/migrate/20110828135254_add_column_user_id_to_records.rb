class AddColumnUserIdToRecords < ActiveRecord::Migration
  def self.up
    add_column :records, :user_id, :integer
  end

  def self.down
  end
end
