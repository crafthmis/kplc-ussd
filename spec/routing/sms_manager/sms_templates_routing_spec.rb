require "rails_helper"

RSpec.describe SmsManager::SmsTemplatesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/sms_manager/sms_templates").to route_to("sms_manager/sms_templates#index")
    end

    it "routes to #new" do
      expect(:get => "/sms_manager/sms_templates/new").to route_to("sms_manager/sms_templates#new")
    end

    it "routes to #show" do
      expect(:get => "/sms_manager/sms_templates/1").to route_to("sms_manager/sms_templates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sms_manager/sms_templates/1/edit").to route_to("sms_manager/sms_templates#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/sms_manager/sms_templates").to route_to("sms_manager/sms_templates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sms_manager/sms_templates/1").to route_to("sms_manager/sms_templates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sms_manager/sms_templates/1").to route_to("sms_manager/sms_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sms_manager/sms_templates/1").to route_to("sms_manager/sms_templates#destroy", :id => "1")
    end
  end
end
