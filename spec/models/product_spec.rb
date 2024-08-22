require 'rails_helper'

RSpec.describe Product, type: :model do
  # Create a valid category and user for association
  let(:category) { create(:category) }
  let(:user) { create(:user) }

  # Define a valid product for use in tests
  let(:product) do
    create(:product,category: category, user: user)
  end

  describe 'validations' do
    it { should belong_to(:category).optional }
    it { should belong_to(:user) }
    it { should have_many(:order_products) }
    it { should have_many(:orders).through(:order_products) }
    it { should have_many_attached(:images) }
    
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(50) }
    it { should validate_length_of(:description).is_at_most(500) }
    
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(1) }
    
    it { should validate_inclusion_of(:is_vegetarian).in_array([true, false]) }
    
    it { should validate_presence_of(:ingredients) }
    it { should validate_length_of(:ingredients).is_at_least(10) }
    
    it { should validate_presence_of(:storage_instructions) }
    it { should validate_length_of(:storage_instructions).is_at_least(10) }
    
    it { should validate_presence_of(:stock_quantity) }
    it { should validate_numericality_of(:stock_quantity).is_greater_than_or_equal_to(0) }
  end

  describe 'callbacks' do
    let(:user) { FactoryBot.create(:user) }
    let(:product) { FactoryBot.create(:product, user: user) }
    let(:order) { FactoryBot.create(:order) }
    let!(:order_product) { FactoryBot.create(:order_product, order: order, product: product, quantity: 10) }

    it 'should prevent destruction if referenced by orders' do
      expect { product.destroy! }.to raise_error(ActiveRecord::RecordNotDestroyed)
    end
  end

  describe 'instance methods' do
    it 'should return correct stock status' do
      expect(product.stock_status).to eq('in_stock')
      
      product.update(stock_quantity: 5)
      expect(product.stock_status).to eq('low_stock')
      
      product.update(stock_quantity: 0)
      expect(product.stock_status).to eq('out_of_stock')
    end

    it 'should check if in stock' do
      expect(product.in_stock?).to be true
      
      product.update(stock_quantity: 0)
      expect(product.in_stock?).to be false
    end

    it 'should check if available quantity is sufficient' do
      expect(product.available_quantity?(5)).to be true
      expect(product.available_quantity?(25)).to be false
    end
  end
end

