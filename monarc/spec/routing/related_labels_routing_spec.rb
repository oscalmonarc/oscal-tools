require "rails_helper"

RSpec.describe RelatedLabelsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/related_labels").to route_to("related_labels#index")
    end

    it "routes to #new" do
      expect(:get => "/related_labels/new").to route_to("related_labels#new")
    end

    it "routes to #show" do
      expect(:get => "/related_labels/1").to route_to("related_labels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/related_labels/1/edit").to route_to("related_labels#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/related_labels").to route_to("related_labels#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/related_labels/1").to route_to("related_labels#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/related_labels/1").to route_to("related_labels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/related_labels/1").to route_to("related_labels#destroy", :id => "1")
    end
  end
end
