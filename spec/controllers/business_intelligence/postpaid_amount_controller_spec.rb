require 'rails_helper'

RSpec.describe BusinessIntelligence::PostpaidAmountController, type: :controller do

  describe "GET #weekly_sale_vs_target" do
    it "returns http success" do
      get :weekly_sale_vs_target
      expect(response).to have_http_status(:success)
    end
  end

end
