require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }

    it 'returns http success' do
      post :create, params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(:created)
    end

    context 'when invalid user or password' do
      it 'returns a 401' do
        post :create, params: { user: { email: 'some@email.com', password: 'somepassword' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

end
