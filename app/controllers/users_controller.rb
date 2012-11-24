#! /bin/env ruby
# encoding: utf-8
class UsersController < ApplicationController
  def index
    if current_user
      @user = current_user
      @new_records = Record.find(:all, :conditions => [" user_id = ? and state = ?",  current_user.id, "new"])
      @group_rules = Rule.find_by_sql(["select * from rules where limits=? and category_id=? and end_time > ? and user_id in (select user_id from friends where friend_id = ?)","group", current_user.category_id.to_s, Time.now.to_s(:db), current_user.id])
      @doing_records = Record.find(:all, :conditions =>["user_id = ? and state = ?", current_user.id,"doing"])
    else
      redirect_to log_in_path
    end
  end

  def new
    @page_title ="注册为考试网会员"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if verify_recaptcha && @user.save
      redirect_to log_in_path
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user.id)
  end


  def update
    @user = User.find(current_user.id)
    @user.update_attributes(params[:user])
    if @user.save
      redirect_to root_path
    else
      render "edit"
    end
  end

  def password_old

  end

  def set_category
    @user = User.find(current_user.id)

  end

  def change_pcbs
    @pcb = Pcb.find(params[:id])
    @user = User.find(current_user.id)
    @user.category_id = @pcb
    @user.save
  end

 def manage_money
   
 end

end
