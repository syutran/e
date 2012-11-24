class CreateRules < ActiveRecord::Migration
  def self.up
    create_table :rules do |t|
      t.integer :user_id
      t.string :title
      t.text :categories
      t.integer :limit_time
      t.integer :single_limit
      t.integer :much_limit
      t.integer :judge_list
      t.datetime :start_time
      t.datetime :end_time
      t.string :limits
      t.boolean :reward
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :rules
  end
end
