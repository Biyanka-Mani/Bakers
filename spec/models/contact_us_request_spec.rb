require 'rails_helper'

RSpec.describe ContactUsRequest, type: :model do
 
  it { should validate_presence_of(:customer_name) }
  it { should validate_length_of(:customer_name).is_at_least(3) }

  it { should validate_presence_of(:customer_email) }
  it { should validate_length_of(:customer_email).is_at_least(8) }
  it { should validate_uniqueness_of(:customer_email).case_insensitive }

  it { should validate_presence_of(:message) }
  it { should validate_length_of(:message).is_at_least(8).is_at_most(500) }
end

