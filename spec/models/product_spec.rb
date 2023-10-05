require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'has a valid factory' do
    product = create(:product)
    expect(product).to be_valid
  end

  it 'is valid with valid attributes' do
    product = build(:product)
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product = build(:product, name: nil)
    expect(product).not_to be_valid
  end

  it 'is not valid without a description' do
    product = build(:product, description: nil)
    expect(product).not_to be_valid
  end

  it 'is not valid without a price' do
    product = build(:product, price: nil)
    expect(product).not_to be_valid
  end
end
