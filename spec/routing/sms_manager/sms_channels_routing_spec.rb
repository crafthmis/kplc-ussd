require "rails_helper"

RSpec.describe SmsManager::SmsChannelsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/sms_manager/sms_channels").to route_to("sms_manager/sms_channels#index")
    end

    it "routes to #new" do
      expect(:get => "/sms_manager/sms_channels/new").to route_to("sms_manager/sms_channels#new")
    end

    it "routes to #show" do
      expect(:get => "/sms_manager/sms_channels/1").to route_to("sms_manager/sms_channels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sms_manager/sms_channels/1/edit").to route_to("sms_manager/sms_channels#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/sms_manager/sms_channels").to route_to("sms_manager/sms_channels#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sms_manager/sms_channels/1").to route_to("sms_manager/sms_channels#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sms_manager/sms_channels/1").to route_to("sms_manager/sms_channels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sms_manager/sms_channels/1").to route_to("sms_manager/sms_channels#destroy", :id => "1")
    end
  end
end
