class OrderMailer < ApplicationMailer
  def new_order_email
    @order=params[:order]
    @products = @order.order_products.includes(:product)  # Include associated products
    mail(to: @order.customer_email, subject: "New order confirmation")
  end
end
