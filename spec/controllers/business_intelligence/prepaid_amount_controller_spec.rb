require 'rails_helper'

RSpec.describe BusinessIntelligence::PrepaidAmountController, type: :controller do

  describe "GET #weekly_sale_million" do
    it "returns http success" do
      get :weekly_sale_million
      expect(response).to have_http_status(:success)
    end
  end

end
