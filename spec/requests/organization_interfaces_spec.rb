require 'rails_helper'

RSpec.describe "OrganizationInterfaces", type: :request do
  describe "GET /organization_interfaces" do
    it "works! (now write some real specs)" do
      get organization_interfaces_path
      expect(response).to have_http_status(200)
    end
  end
end
