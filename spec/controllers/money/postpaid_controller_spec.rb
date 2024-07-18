require 'rails_helper'

RSpec.describe Money::PostpaidController, type: :controller do

  describe "GET #safaricom" do
    it "returns http success" do
      get :safaricom
      expect(response).to have_http_status(:success)
    end
  end

end
