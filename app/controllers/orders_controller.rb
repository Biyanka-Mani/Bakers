class OrdersController < ApplicationController
  # app/controllers/orders_controller.rb
   before_action :AllProducts
  
  
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
    @products = Product.all # Assuming you want to show all available products for selection
  end
  

end
