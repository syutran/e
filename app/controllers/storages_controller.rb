# encoding: utf-8
class StoragesController < ApplicationController
  def index
    @storages = current_user.storages.order("id desc")
    flash[:notice] = "您还没有创建任何题库题目" if @storages.blank?
  end

  def storages_list
    if params[:ucid].blank?
      @storages = current_user.storages.order("id desc")
    else
      ucid = params[:ucid].values
      ucid = ucid.join(",")
      @storages = current_user.storages.where("category_id in (" + ucid.to_s + ")").order("id desc")
    end
  end

  def new
    if current_user.user_categories.all.blank?
      flash[:notice] ="您还没有创建自己的分类！"
      redirect_to user_categories_path
    else
      @storage = Storage.new
      @user_categories = current_user.user_categories.all
      @storages = current_user.storages.all.last(3)
    end
  end

  def create
    @storage = current_user.storages.new(params[:storage])
    if @storage.save
      redirect_to storages_path
    else
      flash.now[:notice] = "创建题目失败！"
       @user_categories = current_user.user_categories.all
       @storages = current_user.storages.all.last(3)
      render "new"
    end
  end

  def show
    @storage = Storage.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @storage = Storage.find(params[:id])
    @storage.destroy
    redirect_to storages_path
  end

  def edit
    @storage = Storage.find(params[:id])
  end

  def update
    @storage = current_user.storages.find(params[:id])
    @storage.update_attribute(:key, "")
    @storage.update_attributes(params[:storage])
    redirect_to storages_path
  end

end
