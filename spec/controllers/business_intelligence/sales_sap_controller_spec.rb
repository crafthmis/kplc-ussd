require 'rails_helper'

RSpec.describe BusinessIntelligence::SalesSapController, type: :controller do

  describe "GET #sales" do
    it "returns http success" do
      get :sales
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #energy_purchase_cost" do
    it "returns http success" do
      get :energy_purchase_cost
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #other_costs" do
    it "returns http success" do
      get :other_costs
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #profit" do
    it "returns http success" do
      get :profit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #sales_vs_cost_trend" do
    it "returns http success" do
      get :sales_vs_cost_trend
      expect(response).to have_http_status(:success)
    end
  end

end
