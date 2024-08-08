class Admin::CategoriesController < ApplicationController
  before_action :set_category,only:[:destroy]
  def index
    @categories = Category.all
    @category=Category.new
  end

  def new
    @category=Category.new
  end
  def create
    @category=Category.new(category_params)
    if @category.save
      flash[:notice]="Category is saved successfully"
      redirect_to admin_categories_path 
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @category.update(category_params)
        flash[:notice]="Category is Updated"
        redirect_to category_path(@category)
    else
      flash[:alert]="Category Updation Error Occured"
        render :edit,status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    flash[:notice]=" Category is Deleted succesfully"
    redirect_to admin_categories_path 
  end
  private 
  def category_params
    params.require(:category).permit(:name,:categoryimage )
  end
  def set_category
    @category=Category.find(params[:id])
  end
end
