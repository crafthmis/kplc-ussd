require 'rails_helper'

RSpec.describe "SmsManager::Contacts", type: :request do
  describe "GET /sms_manager/contacts" do
    it "works! (now write some real specs)" do
      get sms_manager_contacts_path
      expect(response).to have_http_status(200)
    end
  end
end
