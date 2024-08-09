class Admin::DashboardController < ApplicationController
  def index
    @total_orders = Order.count
    @total_pending = Order.where.not(order_status: 'picked_up').count
    @total_enquiries = ContactUsRequest.count
    @total_sales = Order.sum(:total_amount)
    @stock_margin_items = Product.where('stock_quantity < ?', 10).limit(10) # Adjust the threshold as needed
  end
  
end
