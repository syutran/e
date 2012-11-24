class CreateMsgs < ActiveRecord::Migration
  def self.up
    create_table :msgs do |t|
      t.integer :user_id
      t.integer :from_user
      t.string :msg
      t.boolean :act

      t.timestamps
    end
  end

  def self.down
    drop_table :msgs
  end
end
