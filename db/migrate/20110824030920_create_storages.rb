class CreateStorages < ActiveRecord::Migration
  def self.up
    create_table :storages do |t|
      t.string :master
      t.integer :user_id
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
      t.string :key
      t.integer :needtime
      t.integer :speed

      t.timestamps
    end
  end

  def self.down
    drop_table :storages
  end
end
