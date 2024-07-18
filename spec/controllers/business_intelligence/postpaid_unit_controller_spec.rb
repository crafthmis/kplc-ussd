require 'rails_helper'

RSpec.describe BusinessIntelligence::PostpaidUnitController, type: :controller do

  describe "GET #weekly_sale_vs_gwh" do
    it "returns http success" do
      get :weekly_sale_vs_gwh
      expect(response).to have_http_status(:success)
    end
  end

end
