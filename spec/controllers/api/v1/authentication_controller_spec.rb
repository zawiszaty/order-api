# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth/login' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

    context 'when login is successful' do
      it 'returns a token and user data' do
        post '/api/v1/auth/login', params: { email: user.email, password: 'password123' }
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['token']).to be_present
        expect(json_response['username']).to eq(user.username)
      end
    end

    context 'when login is unsuccessful' do
      it 'returns unauthorized' do
        post '/api/v1/auth/login', params: { email: user.email, password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('unauthorized')
      end
    end
  end
end