require 'rails_helper'

RSpec.describe BusinessIntelligence::UnservedEnergyController, type: :controller do

  describe "GET #unserved_energy_table" do
    it "returns http success" do
      get :unserved_energy_table
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #unserved_energy_chart" do
    it "returns http success" do
      get :unserved_energy_chart
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #weekly_unserved_energy" do
    it "returns http success" do
      get :weekly_unserved_energy
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #weekly_regional_trend" do
    it "returns http success" do
      get :weekly_regional_trend
      expect(response).to have_http_status(:success)
    end
  end

end
