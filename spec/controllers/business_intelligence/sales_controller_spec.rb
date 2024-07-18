require 'rails_helper'

RSpec.describe BusinessIntelligence::SalesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #amount_units" do
    it "returns http success" do
      get :amount_units
      expect(response).to have_http_status(:success)
    end
  end

end
