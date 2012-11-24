class UserCategoriesController < ApplicationController
  def index
    @user_categories = current_user.user_categories
    if @user_categories.blank?
      flash[:notice] = "您还没有创建任何自己的分类"
      redirect_to new_user_category_path
    else
      
    end
  end
  def new
    @user_category = UserCategory.new
  end

  def create
    @user_category = current_user.user_categories.new(params[:user_category])
    if @user_category.save
      redirect_to user_categories_path
    else
      render "new"
    end
  end

  def edit
    @user_category = current_user.user_categories.find(params[:id])
  end

  def update
    @user_category = current_user.user_categories.find(params[:id])
    @user_category.update_attributes(params[:user_category])
    redirect_to user_categories_path
  end

  def change_user_category
    current_user.update_attribute(:user_category_id, params[:id])
    redirect_to users_path
  end
end
