require 'rails_helper'

RSpec.describe "control_overlays/new", type: :view do
  before(:each) do
    assign(:control_overlay, ControlOverlay.new(
      :security_policy => nil,
      :domain_environment => nil,
      :overlay_field => nil,
      :overlay_value => "MyString",
      :security_control => nil
    ))
  end

  it "renders new control_overlay form" do
    render

    assert_select "form[action=?][method=?]", control_overlays_path, "post" do

      assert_select "input[name=?]", "control_overlay[security_policy_id]"

      assert_select "input[name=?]", "control_overlay[domain_environment_id]"

      assert_select "input[name=?]", "control_overlay[overlay_field_id]"

      assert_select "input[name=?]", "control_overlay[overlay_value]"

      assert_select "input[name=?]", "control_overlay[security_control_id]"
    end
  end
end
