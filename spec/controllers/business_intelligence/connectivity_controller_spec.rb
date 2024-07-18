require 'rails_helper'

RSpec.describe BusinessIntelligence::ConnectivityController, type: :controller do

  describe "GET #year_to_date_connectivity" do
    it "returns http success" do
      get :year_to_date_connectivity
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #year_to_date_performance" do
    it "returns http success" do
      get :year_to_date_performance
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #year_to_date_variance" do
    it "returns http success" do
      get :year_to_date_variance
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #month_to_date_performace" do
    it "returns http success" do
      get :month_to_date_performace
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #month_to_date_variance" do
    it "returns http success" do
      get :month_to_date_variance
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #connectivity" do
    it "returns http success" do
      get :connectivity
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #trend" do
    it "returns http success" do
      get :trend
      expect(response).to have_http_status(:success)
    end
  end

end
