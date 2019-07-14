require 'rails_helper'

RSpec.describe Api::V1Controller, type: :controller do
  describe 'restrict_access' do
    let(:user) { FactoryBot.create(:user) }

    controller do
      before_action :restrict_access
      def show
      end
    end

    it 'authenticates user' do
      routes.draw { get 'show' => 'api/v1#show' }
      get :show, format: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it 'sets current user' do
      routes.draw { get 'show' => 'api/v1#show' }
      headers = { 'Authorization' => "Token token=1234, email=#{user.email}" }
      request.headers.merge! headers
      get :show, format: :json
      expect(assigns(:current_user)).to eq user
    end
  end
end