require 'rails_helper'

RSpec.describe "DomainEnvironments", type: :request do
  describe "GET /domain_environments" do
    it "works! (now write some real specs)" do
      get domain_environments_path
      expect(response).to have_http_status(200)
    end
  end
end
