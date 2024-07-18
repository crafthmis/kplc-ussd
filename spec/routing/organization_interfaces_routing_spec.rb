require "rails_helper"

RSpec.describe OrganizationInterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/organization_interfaces").to route_to("organization_interfaces#index")
    end

    it "routes to #new" do
      expect(:get => "/organization_interfaces/new").to route_to("organization_interfaces#new")
    end

    it "routes to #show" do
      expect(:get => "/organization_interfaces/1").to route_to("organization_interfaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/organization_interfaces/1/edit").to route_to("organization_interfaces#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/organization_interfaces").to route_to("organization_interfaces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/organization_interfaces/1").to route_to("organization_interfaces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/organization_interfaces/1").to route_to("organization_interfaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/organization_interfaces/1").to route_to("organization_interfaces#destroy", :id => "1")
    end
  end
end
