require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      let(:product1) { create(:product) }
      let(:product2) { create(:product) }
      let(:user) { create(:user)}

      it 'creates a new order with order products' do
        order_params = {
          order: {
            order_products_attributes: [
              { product_id: product1.id, amount: 2 },
              { product_id: product2.id, amount: 3 }
            ]
          }
        }
        request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"

        post :create, params: order_params

        expect(response).to have_http_status(:created)
        expect(Order.count).to eq(1)
        expect(OrderProduct.count).to eq(2)
      end
    end

    context 'with invalid attributes' do
      let(:product1) { create(:product) }
      let(:user) { create(:user)}

      it 'does not create a new order' do
        order_params = {
          order: {
            order_products_attributes: [{ product_id: nil, amount: 2 }]
          }
        }
        request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"

        post :create, params: order_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(Order.count).to eq(0)
        expect(OrderProduct.count).to eq(0)
      end

      it 'does not create a new order when amount of products is equals to 0' do
        order_params = {
          order: {
            order_products_attributes: [{ product_id: product1.id, amount: 0 }]
          }
        }
        request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"

        post :create, params: order_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(Order.count).to eq(0)
        expect(OrderProduct.count).to eq(0)
      end
    end
  end
end
