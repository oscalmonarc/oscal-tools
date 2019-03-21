require 'rails_helper'

RSpec.describe "control_overlays/edit", type: :view do
  before(:each) do
    @control_overlay = assign(:control_overlay, ControlOverlay.create!(
      :security_policy => nil,
      :domain_environment => nil,
      :overlay_field => nil,
      :overlay_value => "MyString",
      :security_control => nil
    ))
  end

  it "renders the edit control_overlay form" do
    render

    assert_select "form[action=?][method=?]", control_overlay_path(@control_overlay), "post" do

      assert_select "input[name=?]", "control_overlay[security_policy_id]"

      assert_select "input[name=?]", "control_overlay[domain_environment_id]"

      assert_select "input[name=?]", "control_overlay[overlay_field_id]"

      assert_select "input[name=?]", "control_overlay[overlay_value]"

      assert_select "input[name=?]", "control_overlay[security_control_id]"
    end
  end
end
