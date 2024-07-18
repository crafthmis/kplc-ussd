require 'rails_helper'

RSpec.describe BusinessIntelligence::FaultyTransformersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #weekly" do
    it "returns http success" do
      get :weekly
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #weekly_trend" do
    it "returns http success" do
      get :weekly_trend
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #weekly_trend_per_region" do
    it "returns http success" do
      get :weekly_trend_per_region
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #faulty_transformers" do
    it "returns http success" do
      get :faulty_transformers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #weekly_transformer_failure" do
    it "returns http success" do
      get :weekly_transformer_failure
      expect(response).to have_http_status(:success)
    end
  end

end
