require "rails_helper"

RSpec.describe TeamInterfacesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/team_interfaces").to route_to("team_interfaces#index")
    end

    it "routes to #new" do
      expect(:get => "/team_interfaces/new").to route_to("team_interfaces#new")
    end

    it "routes to #show" do
      expect(:get => "/team_interfaces/1").to route_to("team_interfaces#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/team_interfaces/1/edit").to route_to("team_interfaces#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/team_interfaces").to route_to("team_interfaces#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/team_interfaces/1").to route_to("team_interfaces#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/team_interfaces/1").to route_to("team_interfaces#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/team_interfaces/1").to route_to("team_interfaces#destroy", :id => "1")
    end
  end
end
