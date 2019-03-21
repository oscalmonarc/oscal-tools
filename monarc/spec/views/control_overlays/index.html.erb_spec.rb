require 'rails_helper'

RSpec.describe "control_overlays/index", type: :view do
  before(:each) do
    assign(:control_overlays, [
      ControlOverlay.create!(
        :security_policy => nil,
        :domain_environment => nil,
        :overlay_field => nil,
        :overlay_value => "Overlay Value",
        :security_control => nil
      ),
      ControlOverlay.create!(
        :security_policy => nil,
        :domain_environment => nil,
        :overlay_field => nil,
        :overlay_value => "Overlay Value",
        :security_control => nil
      )
    ])
  end

  it "renders a list of control_overlays" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Overlay Value".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
