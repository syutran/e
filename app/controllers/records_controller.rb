# encoding: utf-8
class RecordsController < ApplicationController
  before_filter :any_categories

  def index
    process_record(current_user.id)
    @new_records = Record.find(:all, :conditions => [" user_id = ? and state = ?",  current_user.id, "new"])
    @doing_records = Record.find(:all, :conditions =>["user_id = ? and state = ?", current_user.id,"doing"])
    @finish_records = Record.find(:all, :conditions =>["user_id = ? and state = ?", current_user.id, "finished"])
    @group_rules = Rule.find_by_sql(["select * from rules where limits=? and category_id=? and end_time > ? and user_id in (select user_id from friends where friend_id = ?)","group", current_user.category_id.to_s, Time.now.to_s(:db), current_user.id])
    @public_rules = Rule.find_by_sql("select * from rules where limits = 'public' and category_id = " + current_user.category_id.to_s + " and end_time > \"" + Time.now.to_s(:db) + "\" ")
  end

  def finished
    @record = Record.find(params[:id])
    if @record.state == "doing"
      @record.update_attribute(:state, "finished")
      @record.update_attribute(:finish_time, Time.now)
      count(params[:id])
    end
    redirect_to record_path(@record)
  end

  def show
    @record = Record.find(params[:id])
  end

  def count(record_id)
    @record = Record.find(record_id)
    @events = @record.events
    total_time = @record.need_time
    success = 0
    success_time = 0
    faileds = 0
    faileds_time = 0
    @events.each do |e|
      if e.akey == e.rkey
        success_time += e.needtime
        success += 1
      else
        faileds_time += e.needtime
        faileds += 1
      end
    end
    @record.update_attribute(:success_time, success_time)
    @record.update_attribute(:success, success)
    @record.update_attribute(:faileds_time, faileds_time)
    @record.update_attribute(:faileds, faileds)
    @record.update_attribute(:score, (success_time.to_f/total_time.to_f) *100)
    if @record.finish_time.blank?
      @record.update_attribute(:finish_time, @record.start_time + @record.need_time)
    end

  end

  def get_doing_records
    @doing_records = Record.find(:all, :conditions =>["user_id = ? and state = ?", current_user.id,"doing"])
    respond_to do |format|
      format.js
    end
  end

  def get_new_records
     @new_records = Record.find(:all, :conditions => [" user_id = ? and state = ?",  current_user.id, "new"])
     respond_to do |format|
       format.js
     end
  end

  def get_public_rules
    @public_rules = Rule.find_by_sql(["select * from rules where end_time > ? and limits = ?",Time.now,"public"])
    flash.now[:notice] = "没有可用的公共规则！" if @public_rules.blank?
    respond_to do |format|
      format.js
    end
  end

  def get_group_rules
    @group_rules = Rule.find_by_sql(["select * from rules where limits=? and category_id=? and end_time > ? and user_id in (select user_id from friends where friend_id = ?)","group", current_user.category_id.to_s, Time.now.to_s(:db), current_user.id])
    flash.now[:notice] = "没有可用的组规则！" if @group_rules.blank?
    respond_to do |format|
      format.js
    end
  end

  def records_list
    @finished_records = current_user.records.find(:all, :conditions =>["state = ? ", "finished"], :order => ["id desc"])
  end

  def process_record(user_id)
    records = Record.find(:all, :conditions =>["user_id = ? and state = ?", user_id, "doing"])
    records.each do |record|
      if record.start_time.to_i + record.need_time < Time.now.to_i + 10
        record.update_attribute(:state, "finished")
        if record.finish_time.blank?
          record.update_attribute(:finish_time, record.start_time + record.need_time)
        end
        count(record.id)
      end
    end
  end

  private

  def any_categories
    if current_user.category_id.blank?
      flash[:notice] = "您没有确定您的行业分类"
      redirect_to edit_user_path(current_user)
    end
  end
end
