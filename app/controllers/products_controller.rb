class ProductsController < ApplicationController
  def index
    @products=Product.all
  end

  def show
    # @products=@category.products
    @product=Product.find(params[:id])
  end

    
end
