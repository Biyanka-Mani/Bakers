# spec/models/contact_info_spec.rb

require 'rails_helper'

RSpec.describe ContactInfo, type: :model do
  let(:contact_info) { FactoryBot.create(:contact_info) }

  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:website) }
  it { should validate_presence_of(:store_timings) }

  it 'is valid with valid attributes' do
    contact_info = FactoryBot.build(:contact_info)
    expect(contact_info).to be_valid
  end
end

