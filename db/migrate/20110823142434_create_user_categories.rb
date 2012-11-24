class CreateUserCategories < ActiveRecord::Migration
  def self.up
    create_table :user_categories do |t|
      t.string :title
      t.string :extent
      t.text :users
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :user_categories
  end
end
