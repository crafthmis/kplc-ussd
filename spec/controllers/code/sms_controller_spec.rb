require 'rails_helper'

RSpec.describe Code::SmsController, type: :controller do

  describe "GET #safaricom" do
    it "returns http success" do
      get :safaricom
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #equitell" do
    it "returns http success" do
      get :equitell
      expect(response).to have_http_status(:success)
    end
  end

end
