class Category < ActiveRecord::Base
  belongs_to :higher,
    :class_name => "Category",
    :foreign_key => "super"
  has_many :lower,
    :class_name => "Category",
    :foreign_key => "super"
end
