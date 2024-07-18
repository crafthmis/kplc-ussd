require "rails_helper"

RSpec.describe SmsManager::CampaignsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/sms_manager/campaigns").to route_to("sms_manager/campaigns#index")
    end

    it "routes to #new" do
      expect(:get => "/sms_manager/campaigns/new").to route_to("sms_manager/campaigns#new")
    end

    it "routes to #show" do
      expect(:get => "/sms_manager/campaigns/1").to route_to("sms_manager/campaigns#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sms_manager/campaigns/1/edit").to route_to("sms_manager/campaigns#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/sms_manager/campaigns").to route_to("sms_manager/campaigns#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sms_manager/campaigns/1").to route_to("sms_manager/campaigns#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sms_manager/campaigns/1").to route_to("sms_manager/campaigns#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sms_manager/campaigns/1").to route_to("sms_manager/campaigns#destroy", :id => "1")
    end
  end
end
