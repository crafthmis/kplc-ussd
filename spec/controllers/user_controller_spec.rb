require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #manage" do
    it "returns http success" do
      get :manage
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #rolify" do
    it "returns http success" do
      get :rolify
      expect(response).to have_http_status(:success)
    end
  end

end
