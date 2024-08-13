class OrdersController < ApplicationController
  # app/controllers/orders_controller.rb
   before_action :AllProducts
   before_action :set_order, only: [:confirmation]
   before_action :authorize_order, only: [:confirmation]
  
  
  def new
    @order = Order.new
    @order.order_products.build # Initialize at least one order product for the nested form
   
  end
  def show 
    @order=Order.find(params[:id])
    @orderproducts=@order.products 
    
  end


  def confirmation
    @order = Order.find(params[:id])
  end

  
  private
  
  def order_params
    params.require(:order).permit(
      :customer_name, :customer_phone, :customer_email, :total_amount,:order_status,
      order_products_attributes: [:id, :product_id, :quantity,:price, :_destroy]
    )
  end
  def AllProducts
    @products = Product.all
  end
  def set_order
    @order = Order.find(params[:id])
  end
  def authorize_order
    unless @order.id == session[:order_id]
      flash[:alert] = "You are not authorized to view this order."
      redirect_to root_path
    end
  end

end
