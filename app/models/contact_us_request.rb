class ContactUsRequest < ApplicationRecord
  validates :customer_email, presence: true
  validates :message, presence: true
end
