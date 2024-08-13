class Product < ApplicationRecord
  belongs_to :category ,optional: true
  belongs_to :user 
  has_many_attached :images 
   
  has_many :order_products
  has_many :orders, through: :order_products  

  validates :name, presence: true,length: {minimum: 3}
  validates :description, presence: true,length: { minimum: 50, maximum: 500 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :is_vegetarian, inclusion: { in: [true, false] }
  validates :ingredients, presence: true, length: { minimum: 10 }
  validates :storage_instructions, presence: true, length: { minimum: 10 }
  
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  before_destroy :ensure_not_referenced_by_any_order

  scope :active, -> { where(active: true) }

  def ensure_not_referenced_by_any_order
    if orders.exists?
      errors.add(:base, 'Cannot delete product: it is referenced by orders')
      throw :abort
    end
  end
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
