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
    @page_title ="注册为会员"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.activated = Digest::SHA2.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join )
    if @user.save
      recipient = @user.email
      title = @user.name + "欢迎您"
      message = "十分感谢您注册成我为我们的会员，点击这个链接：http://localhost:3000/user_activated_" + @user.activated + " 激活您的账号！"
      UserMailer.confirm(recipient,title,message).deliver
      redirect_to user_activated_path
    else
      render "new"
    end
  end
  def activated
    render :text => "我们已将用于激活账号的链接发至您的邮箱，请注意查收并于3天内将账号激活！"
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
