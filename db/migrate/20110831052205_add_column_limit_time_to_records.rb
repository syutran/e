class AddColumnLimitTimeToRecords < ActiveRecord::Migration
  def self.up
    add_column :records, :limit_time, :datetime
  end

  def self.down
  end
end
