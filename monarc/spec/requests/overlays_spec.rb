require 'rails_helper'

RSpec.describe "Overlays", type: :request do
  describe "GET /overlays" do
    it "works! (now write some real specs)" do
      get overlays_path
      expect(response).to have_http_status(200)
    end
  end
end
