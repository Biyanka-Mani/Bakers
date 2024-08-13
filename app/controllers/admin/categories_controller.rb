class Admin::CategoriesController < ApplicationController
  before_action :set_category,only:[:destroy]
  before_action :authenticate_user!
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
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
              "category_form_modal", 
              partial: "form", 
              locals: { category: @category }
            )
          end
          format.html { render :new, status: :unprocessable_entity }
        end
      end

    end



  def destroy
    if @category.products.exists?
      redirect_to admin_category_path, alert: "Cannot delete category with associated products."
    else
      @category.destroy
      redirect_to admin_categories_path, notice: "Category successfully deleted."
    end 
  end
  private 
  def category_params
    params.require(:category).permit(:name,:categoryimage )
  end
  def set_category
    @category=Category.find(params[:id])
  end
end
