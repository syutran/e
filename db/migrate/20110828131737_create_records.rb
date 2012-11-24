class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.string :title
      t.string :state
      t.integer :need_time
      t.integer :source_user_id
      t.integer :use_time
      t.integer :reward
      t.datetime :start_time
      t.datetime :finish_time
      t.integer :score
      t.text :records
      
      t.datetime :timestamps
    
    end
  end

  def self.down
    drop_table :records
  end
end
