# encoding: utf-8
class RulesController < ApplicationController

  def home
    if params[:id].blank? || params[:id].to_i == 0
      @last_rules = Rule.find(:all, :conditions => ["end_time > ?",Time.now])
    else
      @c_list = Category.find(:all, :conditions => ["super = ?", params[:id]]).map { |c|c.id  }
      unless @c_list.blank?
        @c_list = @c_list.join(",")
      else
        @c_list = params[:id]
      end
      @last_rules = Rule.find(:all, :conditions =>["category_id in (" +  @c_list + ")"])
      if @last_rules.blank?
        flash.now[:notice] = "没找到啊"
        @last_rules = Rule.last(20)
      end
    end
  end
  def index
    if current_user.rules.all.blank?
      flash[:notice] = "您还没有创建任何规则"
      redirect_to new_rule_path
    else
      if params[:request_rules].blank?
        @rules = current_user.rules.find(:all,:order => "id desc")
      else
        case params[:request_rules]
        when "effective"
          @rules = current_user.rules.find(:all, :conditions => ["end_time > ?", Time.now], :order => "id desc")
        when "invalid"
          @rules = current_user.rules.find(:all, :conditions => ["end_time < ?", Time.now], :order => "id desc")
        when "nostart"
          @rules = current_user.rules.find(:all, :conditions => ["start_time >?", Time.now], :order => "id desc")
        else
          @rules = current-user.rules.find(:all, :order => "id desc")
        end
      end
    end
  end

  def new
    if current_user.user_categories.all.blank?
      flash[:notice] = "您还没有创建自己的分类呢"
      redirect_to new_user_category_path
    end
    @now_rules = current_user.rules.find(:all, :conditions =>["end_time > ? ", Time.now])

      if @now_rules.blank? || @now_rules.length < current_user.limit_rules
        @rule = Rule.new
        @user_categories = current_user.user_categories.find(:all)
      else
        flash[:notice] = "您的有效规则超过了限量"
        redirect_to rules_path
      end

  end

  def create
    @rule = current_user.rules.new(params[:rule])
    @rule.save
    redirect_to rules_path
  end

  def edit
    @rule = Rule.find(params[:id])
  end

  def update
    @rule = Rule.find(params[:id])
    @rule.update_attributes(params[:rule])
    redirect_to rule_path(@rule)
  end
  def show
    @rule = current_user.rules.find(params[:id])
    @records = Record.find_by_sql(["select * from records where rule_id =? order by finish_time desc ", @rule.id.to_s])
  end
  def rule_show_records
    @rule = current_user.rules.find(params[:id])
    case params[:byorder]
    when "name"
      @records = Record.find(:all, :conditions => ["rule_id =?", @rule.id.to_s], :joins =>"left join users on users.id = user_id", :order =>"name")
    when "namedesc"
      @records = Record.find(:all, :conditions => ["rule_id =?", @rule.id.to_s], :joins =>"left join users on users.id = user_id", :order =>"name desc")
    when "score"
      @records = Record.find(:all, :conditions => ["rule_id =?", @rule.id.to_s], :order =>"score")
    when "scoredesc"
      @records = Record.find(:all, :conditions => ["rule_id =?", @rule.id.to_s], :order =>"score desc")
    when "start"
      @records = Record.find(:all, :conditions => ["rule_id =?", @rule.id.to_s], :order =>"start_time")
    when "startdesc"
      @records = Record.find(:all, :conditions => ["rule_id =?", @rule.id.to_s], :order =>"start_time desc")
    end
    respond_to do |format|
      format.js
    end
  end

  def create_event
    #开始生成试卷
    @rule = Rule.find(params[:id])
    @ever_records = Record.find(:all, :conditions => ["rule_id = ? and user_id = ? and state in ('new','doing')", @rule.id, current_user.id])
    if @ever_records.blank?

      cate = @rule.user_categories.map {|c| c.id}
      cate = cate.join(",")
      @storages = Storage.find_by_sql("select * from storages where category_id in (" + cate + ") order by rand()") #随机题库
      if @storages.length > 0
        @totaltime = 0

        # 创建新的考试记录
        @record = Record.new
        @record.title = @rule.title
        @record.need_time = @rule.limit_time
        @record.state = "create"
        @record.rule_id = @rule.id
        @record.user_id = current_user.id
        @record.save                                                        #先保存部分记录信息


        @record_event_id =[]
        @storages.each do |s|
          @event = Event.new
          @event.record_id = @record.id
          @event.storage_id = s.id
          @event.user_id = current_user.id
          @event.rule_id = @rule.id
          @event.category_id = s.category_id
          @event.typies = s.typies
          @event.needtime = s.needtime
          @event.title = s.title
          @event.itema = s.itema unless s.itema.blank?
          @event.itemb =  s.itemb unless s.itemb.blank?
          @event.itemc = s.itemc unless s.itemc.blank?
          @event.itemd = s.itemd unless s.itemd.blank?
          @event.iteme = s.iteme unless s.iteme.blank?
          @event.itemf = s.itemf unless s.itemf.blank?
          @event.itemg = s.itemg unless s.itemg.blank?
          @event.itemh = s.itemh unless s.itemh.blank?
          @event.itemi = s.itemi unless s.itemi.blank?
          @event.itemj = s.itemj unless s.itemj.blank?
          @event.rkey = s.key
          @event.akey = ""
          @event.save
          @record_event_id << @event.id
          @totaltime += s.needtime
          break if @totaltime >= @rule.limit_time * 60
        end
        @record.update_attribute(:state, "new")
        @record.update_attribute(:need_time, @totaltime)
        @record.update_attribute(:records, @record_event_id.join(","))
        @record.user.update_attribute(:money, @record.user.money - @rule.fee)
        @rule.user.update_attribute(:money, @rule.user.money + @rule.fee)
        #结束生成试卷
        flash[:notice] = "试卷已经生成！"
        redirect_to :controller => "events", :action => "eventing", :id => @record
      else
        flash[:notice] = "没有相关试题，无法生成试卷"
      end
    else
      redirect_to records_path
      
    end

  end

  def new_event
    @rule = Rule.find(params[:id])

  end
end
