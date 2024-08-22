require 'rails_helper'

RSpec.describe Order, type: :model do
  # Test associations
  it { should have_many(:order_products).dependent(:destroy) }
  it { should have_many(:products).through(:order_products) }

  # Test nested attributes
  it { should accept_nested_attributes_for(:order_products).allow_destroy(true) }

  # Test enum
  it { should define_enum_for(:order_status).with_values([:confirmed, :processing, :ready, :picked_up]) }

  # Test validations
  it { should validate_presence_of(:customer_name) }
  it { should validate_length_of(:customer_name).is_at_least(3).is_at_most(15) }

  it { should validate_presence_of(:customer_email) }
  it { should validate_length_of(:customer_email).is_at_least(8) }

  it { should validate_presence_of(:customer_phone) }
  it { should allow_value('+1234567890').for(:customer_phone) }
  it { should_not allow_value('123').for(:customer_phone).with_message("must be a valid phone number") }

  # Test custom validation
  describe 'custom validation: stock_count_must_be_sufficient' do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product, stock_quantity: 5, user: user) }
    let(:order) { FactoryBot.build(:order) }
    let!(:order_product) { FactoryBot.build(:order_product, order: order, product: product, quantity: 10) }

    it 'adds an error when the order quantity exceeds available stock' do
      order.order_products << order_product
      order.valid?
      expect(order.errors[:base]).to include("The quantity of Sample Product exceeds the available stock.")
    end
  end
end

