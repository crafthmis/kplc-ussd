require 'rails_helper'

RSpec.describe BusinessIntelligence::PrepaidUnitController, type: :controller do

  describe "GET #weekly_sale_trend" do
    it "returns http success" do
      get :weekly_sale_trend
      expect(response).to have_http_status(:success)
    end
  end

end
