class Product < ApplicationRecord
  belongs_to :category 
  belongs_to :user 
  has_many_attached :images 
   
  has_many :order_products
  has_many :orders, through: :order_products    
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  def stock_status
    if stock_quantity == 0
      'out_of_stock'
    elsif stock_quantity < 10
      'low_stock'
    else
      'in_stock'
    end
  end
  def in_stock?
    stock_quantity > 0
  end

  def available_quantity?(requested_quantity)
    stock_quantity >= requested_quantity
  end
end
