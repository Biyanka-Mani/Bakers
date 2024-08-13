class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product,only: [:edit,:destroy,:update]
  def new
    @product = Product.new
  end
  def index
    @search_term = params[:search_term]
    @category_id = params[:category_id]
    @categories = Category.all
  
    @products = Product.paginate(page: params[:page], per_page: 7)
    @products = @products.where("name LIKE ?", "%#{@search_term}%") if @search_term.present?
    @products = @products.where(category_id: @category_id) if @category_id.present?
  end

  def create
    @product=current_user.products.build(product_params)
  
    if @product.save
        flash[:notice]="Product Created Successfully"
        redirect_to admin_product_path(@product)
    else
        flash.now[:alert]="Product Creation Error Occured"
        render :new,status: :unprocessable_entity
    end
  end

  def edit
        
  end
  def update
    if @product.update(product_params)
      flash[:notice]="Product is Updated"
      redirect_to admin_products_path
    else
    flash[:alert]="Product Updation Error Occured"
      render :edit,status: :unprocessable_entity
    end
  end
  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to admin_products_path, notice: 'Product was successfully deleted.'
    else
      redirect_to admin_products_path, alert: @product.errors.full_messages.join(', ')
    end
  end
  private 

    def product_params
        params.require(:product).permit(:name,:description,:category_id,:unit_price,:stock_quantity,:is_vegetarian,:ingredients,:storage_instructions,:active,images: [] )
    end
    def find_category
        @category=Category.find(params[:id])
    end
    def find_product
      @product = Product.find_by(id: params[:id])
      if @product.nil?
        flash[:alert] = "Product not found."
        redirect_to admin_products_path
      end
    end
    
end
