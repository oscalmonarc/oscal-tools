require 'rails_helper'

RSpec.describe "ComponentDomains", type: :request do
  describe "GET /component_domains" do
    it "works! (now write some real specs)" do
      get component_domains_path
      expect(response).to have_http_status(200)
    end
  end
end
