require 'rails_helper'

RSpec.describe "ControlImplementations", type: :request do
  describe "GET /control_implementations" do
    it "works! (now write some real specs)" do
      get control_implementations_path
      expect(response).to have_http_status(200)
    end
  end
end
