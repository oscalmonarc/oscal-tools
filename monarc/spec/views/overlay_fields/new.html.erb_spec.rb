require 'rails_helper'

RSpec.describe "overlay_fields/new", type: :view do
  before(:each) do
    assign(:overlay_field, OverlayField.new(
      :overlay => "",
      :name => "MyString"
    ))
  end

  it "renders new overlay_field form" do
    render

    assert_select "form[action=?][method=?]", overlay_fields_path, "post" do

      assert_select "input[name=?]", "overlay_field[overlay]"

      assert_select "input[name=?]", "overlay_field[name]"
    end
  end
end
