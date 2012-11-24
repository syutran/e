# encoding: utf-8
module RulesHelper
  def select_limit_time
    [["5分钟",5],["10分钟",10],["15分钟",15],["20分钟",20],["30分钟",30],["45分钟",45],["60分钟",60]]
  end

  def select_fee
    [["免费",0.00],["1分钱",0.01],["5分钱",0.05],["１毛钱",0.10],["2毛钱",0.20],["3毛钱",0.30],["5毛钱",0.50],["8毛钱",0.80],["1块钱",1.00],["1块5",1.50],["2块钱",2.00],["3块钱",3.00]]
  end

  def is_friend(main_user_id,cous_user_id)
    u = User.find(main_user_id)
    friend = Friend.find_by_sql(["select friend_id from friends where user_id = ? and friend_id = ?", main_user_id,cous_user_id])
    if friend.blank?
      return false
    else
      return true
    end 
  end

  # can_do_rule 用户是否有权限做这个试卷
  def can_do_rule(ru)
    rule = Rule.find(ru)
    can = false
    sta =[]
    if current_user.money > rule.fee
      records = current_user.records.find(:all, :conditions => ["rule_id = ?", rule.id]) #查看用户是否已经有这个试卷
      if records.length > 0
        records.each do |record|
          sta << record.state
        end
        if sta.include?("new") || sta.include?("doing")
          can = false
        elsif sta.include?("finished") && rule.limits == "public"  #如果本试卷是公共的，并且用户已经完成，可以做
          can = true
        end
      else
        if rule.limits == "public"
          can = true #如果用户没有做过，并且题是公共的，可以做
        elsif rule.limits == "group" && is_friend(rule.user_id, current_user.id)
          can = true
        end
      end
    else
      can = false
    end
    can
  end

end
