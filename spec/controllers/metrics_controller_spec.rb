require 'rails_helper'

RSpec.describe MetricsController, type: :controller do
  describe 'GET #show' do
    let(:metric) { FactoryGirl.create :metric }

    it 'returns http success' do
      expect_any_instance_of(Metric).to receive(:last_hours).with(26).and_return([])
      get :show, id: metric.id, format: :json
      expect(response).to have_http_status(:success)
    end
  end
end
