class Order < ApplicationRecord
  enum order_status: { confirmed: 0, processing: 1, ready: 2, picked_up: 3 }
   has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true
  
 
  # Validations (if needed)
  validates :customer_name, presence: true,length: {minimum:3, maximum:15}
  validates :customer_email, presence: true,length: {minimum: 8}
  validates :customer_phone, presence: true, format: { with: /\A\+?\d{10,15}\z/, message: "must be a valid phone number" }
  validate :stock_count_must_be_sufficient

  private
  def stock_count_must_be_sufficient
    order_products.each do |order_product|
      product = order_product.product
      if order_product.quantity > product.stock_quantity
        errors.add(:base, "The quantity of #{product.name} exceeds the available stock.")
      end
    end
  end
end
