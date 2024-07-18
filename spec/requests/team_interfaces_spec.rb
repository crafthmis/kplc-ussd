require 'rails_helper'

RSpec.describe "TeamInterfaces", type: :request do
  describe "GET /team_interfaces" do
    it "works! (now write some real specs)" do
      get team_interfaces_path
      expect(response).to have_http_status(200)
    end
  end
end
