class CreateRuleCategories < ActiveRecord::Migration
  def self.up
    create_table :rule_categories do |t|
      t.integer :rule_id
      t.integer :user_category_id
      

      t.timestamps
    end
  end

  def self.down
    drop_table :rule_categories
  end
end
