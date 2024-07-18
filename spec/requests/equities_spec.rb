require 'rails_helper'

RSpec.describe "Equities", type: :request do
  describe "GET /equities" do
    it "works! (now write some real specs)" do
      get equities_path
      expect(response).to have_http_status(200)
    end
  end
end
