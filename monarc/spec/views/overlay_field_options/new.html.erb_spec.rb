require 'rails_helper'

RSpec.describe "overlay_field_options/new", type: :view do
  before(:each) do
    assign(:overlay_field_option, OverlayFieldOption.new(
      :overlay_field => nil,
      :name => "MyString"
    ))
  end

  it "renders new overlay_field_option form" do
    render

    assert_select "form[action=?][method=?]", overlay_field_options_path, "post" do

      assert_select "input[name=?]", "overlay_field_option[overlay_field_id]"

      assert_select "input[name=?]", "overlay_field_option[name]"
    end
  end
end
