require "rails_helper"

RSpec.describe ControlOverlaysController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/control_overlays").to route_to("control_overlays#index")
    end

    it "routes to #new" do
      expect(:get => "/control_overlays/new").to route_to("control_overlays#new")
    end

    it "routes to #show" do
      expect(:get => "/control_overlays/1").to route_to("control_overlays#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/control_overlays/1/edit").to route_to("control_overlays#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/control_overlays").to route_to("control_overlays#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/control_overlays/1").to route_to("control_overlays#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/control_overlays/1").to route_to("control_overlays#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/control_overlays/1").to route_to("control_overlays#destroy", :id => "1")
    end
  end
end
