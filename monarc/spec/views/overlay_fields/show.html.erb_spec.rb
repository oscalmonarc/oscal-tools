require 'rails_helper'

RSpec.describe "overlay_fields/show", type: :view do
  before(:each) do
    @overlay_field = assign(:overlay_field, OverlayField.create!(
      :overlay => "",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
  end
end
