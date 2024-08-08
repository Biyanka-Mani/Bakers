class Product < ApplicationRecord
  belongs_to :category 
  belongs_to :user 
  has_many_attached :images 
   
  has_many :order_products
  has_many :orders, through: :order_products    
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
end
