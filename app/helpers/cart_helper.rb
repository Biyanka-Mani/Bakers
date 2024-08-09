module CartHelper
  def calculate_subtotal(cart)
    cart.sum do |item|
      product = Product.find(item["product_id"])
      product.unit_price * item["quantity"]
    end
  end
end
