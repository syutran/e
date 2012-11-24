class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :rule
  has_many :events

end
