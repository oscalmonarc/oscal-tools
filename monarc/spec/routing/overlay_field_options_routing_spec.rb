require "rails_helper"

RSpec.describe OverlayFieldOptionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/overlay_field_options").to route_to("overlay_field_options#index")
    end

    it "routes to #new" do
      expect(:get => "/overlay_field_options/new").to route_to("overlay_field_options#new")
    end

    it "routes to #show" do
      expect(:get => "/overlay_field_options/1").to route_to("overlay_field_options#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/overlay_field_options/1/edit").to route_to("overlay_field_options#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/overlay_field_options").to route_to("overlay_field_options#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/overlay_field_options/1").to route_to("overlay_field_options#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/overlay_field_options/1").to route_to("overlay_field_options#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/overlay_field_options/1").to route_to("overlay_field_options#destroy", :id => "1")
    end
  end
end
