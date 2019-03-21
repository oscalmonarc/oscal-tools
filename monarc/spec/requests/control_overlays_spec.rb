require 'rails_helper'

RSpec.describe "ControlOverlays", type: :request do
  describe "GET /control_overlays" do
    it "works! (now write some real specs)" do
      get control_overlays_path
      expect(response).to have_http_status(200)
    end
  end
end
