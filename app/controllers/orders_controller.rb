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

  def create
    @order = Order.new(order_params)
    @order.order_status = :confirmed
    @order.total_amount = calculate_total_amount
    ActiveRecord::Base.transaction do
      if @order.save
        session[:cart].each do |item|
          @order.order_products.create!(product_id: item[:product_id], quantity: item[:quantity],price:item[:price])
          debugger
          product = Product.find(item[:product_id])
          if product.stock_count >= item[:quantity]
            product.update!(stock_count: product.stock_quantity - item[:quantity])
           
            OrderMailer.with(order: @order).new_order_email.deliver_later
          else
            @order.errors.add(:base, "Insufficient stock for #{product.name}.")
            @order.destroy!
            render :checkout and return
          end
        end
        session[:cart] = []
        redirect_to @order, notice: 'Order was successfully created.'
      else
        render :checkout
      end
    end
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
