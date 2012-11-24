# encoding: utf-8
class CategoriesController < ApplicationController
  def index
    @categories = Category.find(:all, :order => 'title', :conditions => ["super =?",1])
  end

  def new
    @category = Category.new
    @super_categories = Category.find(:all,:order => 'title', :conditions => ["super <= ?", 1]).collect{|c|[c.title,c.id]}

  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to categories_path
    else
      render "new"
    end
  end

  def select_sub
    @category_id = params[:id]
    @sub_categories = Category.find(:all,:order => 'title', :conditions => ["super = ?", params[:id]])
    flash.now[:notice] = "还没有二级分类！" if @sub_categories.blank?
    respond_to do |format|
      format.js
    end
  end

  def select_category
    @user = User.find(current_user)
    if @user.category_id.blank?
      @user.update_attribute(:category_id, params[:id])
      flash[:notice] = "您选择的行业成功！"
    else
      flash[:notice] = "您已经属于一个行业！"
    end
    redirect_to user_path(current_user)
  end
end
