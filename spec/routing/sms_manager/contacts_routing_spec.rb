require "rails_helper"

RSpec.describe SmsManager::ContactsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/sms_manager/contacts").to route_to("sms_manager/contacts#index")
    end

    it "routes to #new" do
      expect(:get => "/sms_manager/contacts/new").to route_to("sms_manager/contacts#new")
    end

    it "routes to #show" do
      expect(:get => "/sms_manager/contacts/1").to route_to("sms_manager/contacts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sms_manager/contacts/1/edit").to route_to("sms_manager/contacts#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/sms_manager/contacts").to route_to("sms_manager/contacts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sms_manager/contacts/1").to route_to("sms_manager/contacts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sms_manager/contacts/1").to route_to("sms_manager/contacts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sms_manager/contacts/1").to route_to("sms_manager/contacts#destroy", :id => "1")
    end
  end
end
