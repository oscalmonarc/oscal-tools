require 'rails_helper'

RSpec.describe "OverlayFieldOptions", type: :request do
  describe "GET /overlay_field_options" do
    it "works! (now write some real specs)" do
      get overlay_field_options_path
      expect(response).to have_http_status(200)
    end
  end
end
