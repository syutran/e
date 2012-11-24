class AddColumnSuccessToRecords < ActiveRecord::Migration
  def self.up
    add_column :records, :success, :integer
    add_column :records, :success_time, :integer
    add_column :records, faileds, :integer
    add_column :records, failed_time, :integer
  end

  def self.down
  end
end
