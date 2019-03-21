require 'rails_helper'

RSpec.describe "control_overlays/show", type: :view do
  before(:each) do
    @control_overlay = assign(:control_overlay, ControlOverlay.create!(
      :security_policy => nil,
      :domain_environment => nil,
      :overlay_field => nil,
      :overlay_value => "Overlay Value",
      :security_control => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Overlay Value/)
    expect(rendered).to match(//)
  end
end
