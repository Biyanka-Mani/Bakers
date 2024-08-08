class Admin::ProductsController < ApplicationController
  def new
    @product = Product.new
  end
  def index
    @search_term = params[:search_term]
    @products = if @search_term.present?
               Product.where("name ILIKE ?", "%#{@search_term}%")
    else
    Product.all
    end
  end

  def create
    @product=current_user.products.build(product_params)
    debugger
    if @product.save
        flash[:notice]="Product Created Successfully"
        redirect_to product_path(@product)
    else
        flash.now[:alert]="Product Creation Error Occured"
        render :new,status: :unprocessable_entity
    end
  end

  def edit
        
  end
  def update
    if @product.update(product_params)
      flash[:notice]="Category is Updated"
      redirect_to category_path(@category)
    else
    flash[:alert]="Category Updation Error Occured"
      render :edit,status: :unprocessable_entity
    end
  end
  def destroy
    @category.destroy
    flash[:notice]="Article is Deleted succesfully"
    redirect_to categories_path 
  end
  private 

    def product_params
        params.require(:product).permit(:name,:description,:category_id,:unit_price,:stock_quantity,:is_vegetarian,:ingredients,:storage_instructions,images: [])
    end
    def find_category
        @category=Category.find(params[:id])
    end
    def find_product
      @product=Product.find(params[:id])
    end
end
