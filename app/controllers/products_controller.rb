class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

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
    @product=Product.find(params[:id])
  end

    
end
