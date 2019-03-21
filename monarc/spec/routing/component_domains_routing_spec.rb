require "rails_helper"

RSpec.describe ComponentDomainsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/component_domains").to route_to("component_domains#index")
    end

    it "routes to #new" do
      expect(:get => "/component_domains/new").to route_to("component_domains#new")
    end

    it "routes to #show" do
      expect(:get => "/component_domains/1").to route_to("component_domains#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/component_domains/1/edit").to route_to("component_domains#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/component_domains").to route_to("component_domains#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/component_domains/1").to route_to("component_domains#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/component_domains/1").to route_to("component_domains#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/component_domains/1").to route_to("component_domains#destroy", :id => "1")
    end
  end
end
