require "rails_helper"

RSpec.describe IncidencesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/incidences").to route_to("incidences#index")
    end

    it "routes to #new" do
      expect(:get => "/incidences/new").to route_to("incidences#new")
    end

    it "routes to #show" do
      expect(:get => "/incidences/1").to route_to("incidences#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/incidences/1/edit").to route_to("incidences#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/incidences").to route_to("incidences#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/incidences/1").to route_to("incidences#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/incidences/1").to route_to("incidences#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/incidences/1").to route_to("incidences#destroy", :id => "1")
    end
  end
end
