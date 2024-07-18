require "rails_helper"

RSpec.describe SmsManager::AudiencesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/sms_manager/audiences").to route_to("sms_manager/audiences#index")
    end

    it "routes to #new" do
      expect(:get => "/sms_manager/audiences/new").to route_to("sms_manager/audiences#new")
    end

    it "routes to #show" do
      expect(:get => "/sms_manager/audiences/1").to route_to("sms_manager/audiences#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sms_manager/audiences/1/edit").to route_to("sms_manager/audiences#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/sms_manager/audiences").to route_to("sms_manager/audiences#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sms_manager/audiences/1").to route_to("sms_manager/audiences#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sms_manager/audiences/1").to route_to("sms_manager/audiences#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sms_manager/audiences/1").to route_to("sms_manager/audiences#destroy", :id => "1")
    end
  end
end
