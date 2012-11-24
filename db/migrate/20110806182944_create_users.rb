class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :sex
      t.date :birthday
      t.string :city
      t.string :address
      t.string :telephone
      t.boolean :act
      t.integer :category_id
      
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
