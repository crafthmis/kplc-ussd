require "rails_helper"

RSpec.describe EquitiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/equities").to route_to("equities#index")
    end

    it "routes to #new" do
      expect(:get => "/equities/new").to route_to("equities#new")
    end

    it "routes to #show" do
      expect(:get => "/equities/1").to route_to("equities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/equities/1/edit").to route_to("equities#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/equities").to route_to("equities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/equities/1").to route_to("equities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/equities/1").to route_to("equities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/equities/1").to route_to("equities#destroy", :id => "1")
    end
  end
end
