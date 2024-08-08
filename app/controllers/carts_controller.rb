# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  def add_to_cart
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
     # Initialize the cart in the session if not already present
     session[:cart] ||= []
    
     # Check if product is already in the cart
     existing_item = session[:cart].find { |item| item["product_id"] == product_id }
     if existing_item
      existing_item["quantity"] = (existing_item["quantity"].to_i + quantity)
     else
       session[:cart] << { product_id: product_id, quantity: quantity }
     end
    
    redirect_to cart_path
  end

  def show
    @cart_items = session[:cart] || []
    product_ids = @cart_items.map { |item| item["product_id"].to_i }
    @products = Product.where(id: product_ids)
    @product_lookup = @products.index_by(&:id)
    debugger
  end

  def checkout
    # @order = Order.new
    # @order.order_products_attributes = session[:cart].map do |item|
    #   {
    #     product_id: item["product_id"],
    #     quantity: item["quantity"]
    #   }
    @cart_items = session[:cart] || []
    product_ids = @cart_items.map { |item| item["product_id"].to_i }
    @products = Product.where(id: product_ids)
    @product_lookup = @products.index_by(&:id)
    @order=Order.new()
  end

  def place_order
    @order = Order.new(order_params)
    @order.order_status = :confirmed
    @order.total_amount = calculate_total_amount
    order_saved = false
  
    ActiveRecord::Base.transaction do
      order_saved = @order.save
      if order_saved
        session[:cart].each do |item|
          product = Product.find(item["product_id"])
          debugger
          if product.stock_quantity >= item["quantity"]
            @order.order_products.create!(product_id: item["product_id"], quantity: item["quantity"],price:product.unit_price)
            product.update!(stock_quantity: product.stock_quantity - item["quantity"])
            
          else
            @order.errors.add(:base, "Insufficient stock for #{product.name}.")
            raise ActiveRecord::Rollback
          end
        end
      end
    end
  
    if order_saved && @order.errors.empty?
      OrderMailer.with(order: @order).new_order_email.deliver_later
      session[:cart] = []
      redirect_to @order, notice: 'Order was successfully created.'
    else
      @order.destroy if order_saved
      render :checkout
    end
  end
  

  private

  def order_params
    params.require(:order).permit(:customer_name, :customer_phone, :customer_email)
  end
  def calculate_total_amount
    @cart_items = session[:cart] || []
    products = Product.where(id: @cart_items.map { |item| item["product_id"].to_i })
    return @cart_items.sum { |item| products.find { |p| p.id == item["product_id"].to_i }.unit_price * item["quantity"] }
  end
end

