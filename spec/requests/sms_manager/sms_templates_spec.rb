require 'rails_helper'

RSpec.describe "SmsManager::SmsTemplates", type: :request do
  describe "GET /sms_manager/sms_templates" do
    it "works! (now write some real specs)" do
      get sms_manager_sms_templates_path
      expect(response).to have_http_status(200)
    end
  end
end
