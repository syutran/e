class UserCategory < ActiveRecord::Base
  belongs_to :user
  has_many :storages
  has_and_belongs_to_many :rules
end
