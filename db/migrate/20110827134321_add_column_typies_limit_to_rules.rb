class AddColumnTypiesLimitToRules < ActiveRecord::Migration
  def self.up
    add_column :rules, :single_limit, :integer
    add_column :rules, :much_limit, :integer
    add_column :rules, :judge_limit, :integer
  end

  def self.down
  end
end
