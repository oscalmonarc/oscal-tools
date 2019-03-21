require "rails_helper"

RSpec.describe OverlaysController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/overlays").to route_to("overlays#index")
    end

    it "routes to #new" do
      expect(:get => "/overlays/new").to route_to("overlays#new")
    end

    it "routes to #show" do
      expect(:get => "/overlays/1").to route_to("overlays#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/overlays/1/edit").to route_to("overlays#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/overlays").to route_to("overlays#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/overlays/1").to route_to("overlays#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/overlays/1").to route_to("overlays#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/overlays/1").to route_to("overlays#destroy", :id => "1")
    end
  end
end
