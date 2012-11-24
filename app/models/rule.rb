# encoding: utf-8
class Rule < ActiveRecord::Base
  belongs_to :user
  has_many :records
  has_and_belongs_to_many :user_categories
  validate :title, :presence => true,:length => { :maximum => 10 }
  validate :has_user_categories?, :presence => {:message => "没有分类列表"}

  def has_user_categories?
    errors.add_to_base "没有任何分类" if self.user_categories.blank?
  end

end
