class AddFaceToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :face_file_name, :string
    add_column :users, :face_content_type, :string
    add_column :users, :face_file_size, :string
  end

  def self.down
  end
end
