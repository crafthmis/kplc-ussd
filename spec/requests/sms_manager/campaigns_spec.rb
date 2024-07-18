require 'rails_helper'

RSpec.describe "SmsManager::Campaigns", type: :request do
  describe "GET /sms_manager/campaigns" do
    it "works! (now write some real specs)" do
      get sms_manager_campaigns_path
      expect(response).to have_http_status(200)
    end
  end
end
