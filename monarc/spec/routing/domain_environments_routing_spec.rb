require "rails_helper"

RSpec.describe DomainEnvironmentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/domain_environments").to route_to("domain_environments#index")
    end

    it "routes to #new" do
      expect(:get => "/domain_environments/new").to route_to("domain_environments#new")
    end

    it "routes to #show" do
      expect(:get => "/domain_environments/1").to route_to("domain_environments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/domain_environments/1/edit").to route_to("domain_environments#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/domain_environments").to route_to("domain_environments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/domain_environments/1").to route_to("domain_environments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/domain_environments/1").to route_to("domain_environments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/domain_environments/1").to route_to("domain_environments#destroy", :id => "1")
    end
  end
end
