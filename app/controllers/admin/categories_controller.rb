class Admin::CategoriesController < ApplicationController
  before_filter :find_category, :only => [:show, :edit, :update, :destroy]
  before_filter :find_sub_categories, :only => [:new, :edit]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @category.save
    redirect_to admin_categories_path
  end

  def edit

  end

  def update
    @category.update_attributes(params[:category])
    redirect_to admin_category_path(@category)
  end

  def show
  end
  
  protected
  def find_category
    @category = Category.find(params[:id])
  end
  
  def find_sub_categories
    @sub_categories = Category.find(:all,:order => 'title', :conditions => ["super <= ?", 1]).collect{|c|[c.title,c.id]}
  end

end
