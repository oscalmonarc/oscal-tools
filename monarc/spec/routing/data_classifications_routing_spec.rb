require "rails_helper"

RSpec.describe DataClassificationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/data_classifications").to route_to("data_classifications#index")
    end

    it "routes to #new" do
      expect(:get => "/data_classifications/new").to route_to("data_classifications#new")
    end

    it "routes to #show" do
      expect(:get => "/data_classifications/1").to route_to("data_classifications#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/data_classifications/1/edit").to route_to("data_classifications#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/data_classifications").to route_to("data_classifications#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/data_classifications/1").to route_to("data_classifications#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/data_classifications/1").to route_to("data_classifications#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/data_classifications/1").to route_to("data_classifications#destroy", :id => "1")
    end
  end
end
