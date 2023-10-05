# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:user) }
  let(:invalid_attributes) { { name: nil, email: 'invalid_email' } }

  describe 'GET /api/v1/users' do
    it 'returns a list of users' do
      create_list(:user, 3)
      request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/users/:username' do
    it 'returns a user by username' do
      request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"
      get :show , params: { _username: user.username }
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response['username']).to eq(user.username)
    end

    it 'returns an error if user not found' do
      request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"
      get :show, params: { _username: 'invalid_username' }
      expect(response).to have_http_status(:not_found)

      json_response = JSON.parse(response.body)
      expect(json_response['errors']).to eq('User not found')
    end
  end
  describe 'POST /api/v1/users' do
    context 'with valid attributes' do
      it 'creates a new user' do
        request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"

        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body)
        expect(json_response['username']).to eq(valid_attributes[:username])
      end
    end

    context 'with invalid attributes' do
      it 'returns unprocessable entity status' do
        request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"

        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'PATCH /api/v1/users/:username' do
    context 'with valid attributes' do
      it 'updates an existing user' do
        request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"
        patch :update, params: { _username: user.username, name: 'Updated Name' }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with invalid attributes' do
      it 'returns unprocessable entity status' do
        request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"

        patch :update, params: { _username: user.username,email: 'invalid_email' }
        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'DELETE /api/v1/users/:username' do
    it 'deletes an existing user' do
      request.headers['Authorization'] = "Bearer #{JsonWebToken.encode(user_id: user.id)}"

      delete :destroy, params: { _username: user.username }
      expect(response).to have_http_status(:no_content)
    end
  end
end