class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  def index
    @categories = Category.all
    @products = Product.where(active:true)

    # Filtering by category
    if params[:category].present? && params[:category] != 'all'
      @products = @products.where(category: params[:category])
    end

    # Filtering by type (veg/non-veg)
    if params[:type].present? && params[:type] != 'all'
      @products = @products.where(is_vegetarian: params[:type] == 'veg')
    end

    # Filtering by price range
    if params[:price_range].present?
      max_price = params[:price_range].to_f
      @products = @products.where('unit_price <= ?', max_price)
    end
  end

  def show
    # @products=@category.products
   
    if @product.active?
    else
      flash[:alert] = "This product is inactive currently."
      redirect_to products_path
    end
  end
  def set_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      flash[:alert] = "Product not found."
      redirect_to products_path
    end
  end
  

    
end
