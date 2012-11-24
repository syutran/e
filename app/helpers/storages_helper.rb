# encoding: utf-8
module StoragesHelper
  def readspeed
    [["中等速度［每秒5字］",5],["无需思考［每秒6字］",6],["需要思考［每秒4字］",4],["需要计算［每秒3字］",3]]
  end
  def user_categories_select(current_user)
    UserCategory.find(:all,:order => 'title', :conditions => ["user_id = ?", current_user.id]).collect{|c|[c.title,c.id]}
  end
end
