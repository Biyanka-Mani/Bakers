# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  include CartHelper
  def add_to_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if !product.in_stock?
      flash[:alert] = "Sorry, this product is out of stock."
      redirect_back(fallback_location: root_path) and return
    end

    if !product.available_quantity?(quantity)
      flash[:alert] = "Sorry, only #{product.stock_quantity} item(s) available."
      redirect_back(fallback_location: root_path) and return
    end

    session[:cart] ||= []
    existing_item = session[:cart].find { |item| item["product_id"] == params[:product_id] }

    if existing_item
      new_quantity = existing_item["quantity"].to_i + quantity
      if product.available_quantity?(new_quantity)
        existing_item["quantity"] = new_quantity
      else
        flash[:alert] = "Sorry, can't add more. Only #{product.stock_quantity} item(s) available in total."
        redirect_back(fallback_location: root_path) and return
      end
    else
      session[:cart] << { product_id: params[:product_id], quantity: quantity }
    end

    flash[:notice] = "Product added to cart successfully."
    redirect_back(fallback_location: root_path)
  end

  def show
    @cart_items = session[:cart] || []
    product_ids = @cart_items.map { |item| item["product_id"].to_i }
    @products = Product.where(id: product_ids)
    @product_lookup = @products.index_by(&:id)
  
  end


  def update
    product_id = params[:product_id]
    quantity = params[:quantity].to_i

    # Find the item in the cart
    item = session[:cart].find { |item| item["product_id"] == product_id }
    if item
      item["quantity"] = quantity
      message = "Cart updated successfully"
      success = true
    else
      message = "Item not found in cart"
      success = false
    end
    subtotal = calculate_subtotal(session[:cart])
    respond_to do |format|
      format.html { redirect_to product_path(product_id), notice: message }
      format.json { render json: { success: success, message: message, subtotal: subtotal } }
    end
  end

  def remove
    product_id = params[:product_id]

    # Remove the item from the cart
    
    if session[:cart].reject! { |item| item["product_id"] == product_id }
      
      message = "Item Removed From Cart"
      success = true
    else
      message = "Item not found in cart"
      success = false
    end

    calculate_subtotal(session[:cart])
    respond_to do |format|
      format.html { redirect_to product_path(product_id), notice: message }
      format.json { render json: { success: success, message: message } }
    end
  end
  def checkout
    @cart_items = session[:cart] || []
    product_ids = @cart_items.map { |item| item["product_id"].to_i }
    @products = Product.where(id: product_ids)
    @product_lookup = @products.index_by(&:id)
    @order=Order.new()
    @total_amount = calculate_total_amount 
  end

  def place_order
    @order = Order.new(order_params)
    @order.order_status = :confirmed
    @order.total_amount = calculate_total_amount
    @total_amount=@order.total_amount
    order_saved = false
  
    ActiveRecord::Base.transaction do
      order_saved = @order.save
      if order_saved
        session[:cart].each do |item|
          product = Product.find(item["product_id"])
          
         
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
      session[:order_id] = @order.id
      redirect_to  confirmation_order_path(@order), notice: 'Your order has been placed successfully!'
    else
      @order.destroy if order_saved
      @cart_items = session[:cart] # Assuming session[:cart] has your cart items
      @product_lookup = Product.where(id: @cart_items.map { |item| item["product_id"] }).index_by(&:id)
      render :checkout,status: :unprocessable_entity
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

