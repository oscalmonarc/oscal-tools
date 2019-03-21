require "rails_helper"

RSpec.describe OverlayFieldsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/overlay_fields").to route_to("overlay_fields#index")
    end

    it "routes to #new" do
      expect(:get => "/overlay_fields/new").to route_to("overlay_fields#new")
    end

    it "routes to #show" do
      expect(:get => "/overlay_fields/1").to route_to("overlay_fields#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/overlay_fields/1/edit").to route_to("overlay_fields#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/overlay_fields").to route_to("overlay_fields#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/overlay_fields/1").to route_to("overlay_fields#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/overlay_fields/1").to route_to("overlay_fields#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/overlay_fields/1").to route_to("overlay_fields#destroy", :id => "1")
    end
  end
end
