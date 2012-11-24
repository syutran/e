class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :storage_id
      t.integer :user_id
      t.integer :rule_id
      t.integer :category_id
      t.string :typies
      t.text :title
      t.text :itema
      t.text :itemb
      t.text :itemc
      t.text :itemd
      t.text :iteme
      t.text :itemf
      t.text :itemg
      t.text :itemh
      t.text :itemi
      t.text :itemj
      t.string :rkey
      t.string :akey
      t.integer :needtime
      

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
