require 'rails_helper'

RSpec.describe "overlay_field_options/edit", type: :view do
  before(:each) do
    @overlay_field_option = assign(:overlay_field_option, OverlayFieldOption.create!(
      :overlay_field => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit overlay_field_option form" do
    render

    assert_select "form[action=?][method=?]", overlay_field_option_path(@overlay_field_option), "post" do

      assert_select "input[name=?]", "overlay_field_option[overlay_field_id]"

      assert_select "input[name=?]", "overlay_field_option[name]"
    end
  end
end
