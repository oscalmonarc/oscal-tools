require 'rails_helper'

RSpec.describe "RelatedLabels", type: :request do
  describe "GET /related_labels" do
    it "works! (now write some real specs)" do
      get related_labels_path
      expect(response).to have_http_status(200)
    end
  end
end
