require 'rails_helper'

RSpec.describe OrderProduct, type: :model do

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:order) }
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end
end
