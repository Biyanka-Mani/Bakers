require 'rails_helper'

RSpec.describe Category, type: :model do
 
  it { should validate_presence_of(:name) } 
  it { should validate_length_of(:name).is_at_least(3) }
  it { should validate_presence_of(:categoryimage) }
  it { should have_many(:products).dependent(:nullify) }

  # Test the has_one_attached association for categoryimage
  it 'has one attached categoryimage' do
    category = Category.new(name: 'Breads')
    expect(category.categoryimage).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end

