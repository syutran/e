class AddColumnTypiesToRules < ActiveRecord::Migration
  def self.up
    add_column :rules, :typies, :string
  end

  def self.down
  end
end
