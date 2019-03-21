require 'rails_helper'

RSpec.describe "overlay_field_options/show", type: :view do
  before(:each) do
    @overlay_field_option = assign(:overlay_field_option, OverlayFieldOption.create!(
      :overlay_field => nil,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
  end
end
