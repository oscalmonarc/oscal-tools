require 'rails_helper'

RSpec.describe "overlays/new", type: :view do
  before(:each) do
    assign(:overlay, Overlay.new(
      :provider => nil,
      :name => "MyString"
    ))
  end

  it "renders new overlay form" do
    render

    assert_select "form[action=?][method=?]", overlays_path, "post" do

      assert_select "input[name=?]", "overlay[provider_id]"

      assert_select "input[name=?]", "overlay[name]"
    end
  end
end
