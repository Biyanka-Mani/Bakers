class Category < ApplicationRecord

  validates :name, presence: true,length: {minimum: 3}
  validates :categoryimage,presence:true

  has_many :products, dependent: :nullify
  has_one_attached :categoryimage 
  
end
