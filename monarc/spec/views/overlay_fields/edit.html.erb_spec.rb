require 'rails_helper'

RSpec.describe "overlay_fields/edit", type: :view do
  before(:each) do
    @overlay_field = assign(:overlay_field, OverlayField.create!(
      :overlay => "",
      :name => "MyString"
    ))
  end

  it "renders the edit overlay_field form" do
    render

    assert_select "form[action=?][method=?]", overlay_field_path(@overlay_field), "post" do

      assert_select "input[name=?]", "overlay_field[overlay]"

      assert_select "input[name=?]", "overlay_field[name]"
    end
  end
end
