class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update,:update_status]
  def index
    @orders = Order.paginate(page: params[:page], per_page: 10)

  
    # Filter by order status
    if params[:order_status].present?
      @orders = @orders.where(order_status: params[:order_status])
    end
  
    # Validate and filter by start date and end date
    start_date, end_date = DateHelper.normalize_date(params[:start_date], params[:end_date])

    if start_date.present? && end_date.present?
      @orders = @orders.where(created_at: start_date..end_date)
    elsif start_date.present?
      @orders = @orders.where('created_at >= ?', start_date)
    elsif end_date.present?
      @orders = @orders.where('created_at <= ?', end_date)
    end
  
    # Sort by order status if specified
    sort_order = params[:sort_by_status].presence || 'desc'
    @orders = @orders.order(created_at: sort_order)

  end

  def show 
    
    @orderproducts=@order.products 
    
  end
  def update
    if @order.update(order_params)
      if @order.picked_up?
        @order.update(picked_up_at: Time.current)
      end
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :show
    end
  end
  def update_status
    @order = Order.find(params[:id])
    if @order.update(order_status: params[:order_status])
      if @order.order_status == 'picked_up'
        @order.update(picked_up_at: Time.current)
      end
      redirect_to admin_order_path(@order), notice: 'Order status was successfully updated.'
    else
      render :show
    end
  end
  private
  def set_order
    @order=Order.find(params[:id])
  end
  def order_params
    params.require(:order).permit(
      :customer_name, :customer_phone, :customer_email, :total_amount,:order_status,
      order_products_attributes: [:id, :product_id, :quantity, :_destroy]
    )
  end

  
  
end
