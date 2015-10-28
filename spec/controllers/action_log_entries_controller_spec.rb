require 'rails_helper'

RSpec.describe ActionLogEntriesController, type: :controller do
  let(:port) { FactoryGirl.create :output }

  describe 'GET #index' do
    it 'returns http success' do
      get :index, port_id: port
      expect(response).to have_http_status(:success)
    end
  end
end
