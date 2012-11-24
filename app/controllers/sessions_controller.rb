# encoding: utf-8
class SessionsController < ApplicationController
  def new
    @page_title = "登录到考试网"
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      session[:event] = rand(999999999)
      #onlines = CGI::Session::ActiveRecordStore::Session.find( :all, :conditions => [ "updated_at = ?", Time.now() - 10.minutes ] )
      #user_session= Session.find_by_data(session[:user_id])
      #user_session.update_attribute(:log_id, user.id)
      if user_info_complate
        redirect_to root_url, :notice => "登录成功"
      else
        redirect_to edit_user_path(current_user.id)
      end
    else
      flash.now.alert = "无效的用户邮箱地址或密码"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "成功退出"
  end


  private
  def user_info_complate
    @user_info = User.find(current_user)
    if @user_info.category_id.blank?
      return false
    elsif @user_info.face_file_name.blank?
      return false
    elsif @user_info.money < 0.01
      return false
    else
      return trun
    end
  end
end
