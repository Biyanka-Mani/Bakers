class ContactInfo < ApplicationRecord
  validates :phone, :email, :address, :website, :store_timings, presence: true
end
