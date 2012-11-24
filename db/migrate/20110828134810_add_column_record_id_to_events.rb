class AddColumnRecordIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :record_id, :integer
  end

  def self.down
  end
end
