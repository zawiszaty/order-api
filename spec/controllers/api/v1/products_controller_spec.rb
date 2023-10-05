require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new product' do
        product_params = FactoryBot.attributes_for(:product)
        thumbnail_file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'thumbnail.jpg'), 'image/jpeg')
        request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"

        post :create, params: { product: product_params.merge(thumbnail: thumbnail_file) }

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new product' do
        product_params = FactoryBot.attributes_for(:product, name: nil)
        request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"

        post :create, params: { product: product_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end