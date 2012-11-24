# encoding: utf-8
module EventsHelper
  def downtime(limit_time)
    limit = 0
    unless limit_time.blank?
       if limit_time - Time.now > 0
        limit = limit_time - Time.now
       else
         limit = 0
      end
    else
      limit = 0
    end
    limit.to_i
  end

  #生成试卷的辅助方法，现在没用
  def create_new_event(rule_id)
    #开始生成试卷
    rule = Rule.find(rule_id)
    cate = rule.user_categories.map {|c| c.id}
    cate = cate.join(",")
    storages = Storage.find_by_sql("select * from storages where category_id in (" + cate + ") order by rand()") #随机题库
    if storages.length > 0
      totaltime = 0

        # 创建新的考试记录
        record = Record.new
        record.title = rule.title
        record.need_time = rule.limit_time
        record.state = "create"
        record.rule_id = rule.id
        record.user_id = current_user.id
        record.save                                                        #先保存部分记录信息


        record_event_id =[]
        storages.each do |s|
          event = Event.new
          event.record_id = record.id
          event.storage_id = s.id
          event.user_id = current_user.id
          event.rule_id = rule.id
          event.category_id = s.category_id
          event.typies = s.typies
          event.needtime = s.needtime
          event.title = s.title
          event.itema = s.itema unless s.itema.blank?
          event.itemb =  s.itemb unless s.itemb.blank?
          event.itemc = s.itemc unless s.itemc.blank?
          event.itemd = s.itemd unless s.itemd.blank?
          event.iteme = s.iteme unless s.iteme.blank?
          event.itemf = s.itemf unless s.itemf.blank?
          event.itemg = s.itemg unless s.itemg.blank?
          event.itemh = s.itemh unless s.itemh.blank?
          event.itemi = s.itemi unless s.itemi.blank?
          event.itemj = s.itemj unless s.itemj.blank?
          event.rkey = s.key
          event.akey = ""
          event.save
          record_event_id << event.id
          totaltime += s.needtime
          break if totaltime >= rule.limit_time * 60
        end
        record.update_attribute(:state, "new")
        record.update_attribute(:need_time, @totaltime)
        record.update_attribute(:records, @record_event_id.join(","))
        #结束生成试卷
        flash[:notice] = "试卷已经生成！"
        return record
    else
      flash[:notice] = "没有相关试题，无法生成试卷"
      return 0
    end
  end
end
