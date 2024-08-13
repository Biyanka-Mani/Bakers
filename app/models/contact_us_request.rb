class ContactUsRequest < ApplicationRecord
  validates :customer_name, presence: true,length: {minimum: 3}
  validates :customer_email, presence: true,length: {minimum: 8},uniqueness: { case_sensitive: false }
  validates :message, presence: true,length: { minimum: 8, maximum: 500 }
end
