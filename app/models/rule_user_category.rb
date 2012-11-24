class RuleUserCategory < ActiveRecord::Base
  belongs_to :rule
  belongs_to :user_category
end
