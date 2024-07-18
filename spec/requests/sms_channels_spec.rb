require 'rails_helper'

RSpec.describe "SmsChannels", type: :request do
  describe "GET /sms_channels" do
    it "works! (now write some real specs)" do
      get sms_channels_path
      expect(response).to have_http_status(200)
    end
  end
end
