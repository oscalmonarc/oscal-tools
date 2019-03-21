require 'rails_helper'

RSpec.describe "overlays/edit", type: :view do
  before(:each) do
    @overlay = assign(:overlay, Overlay.create!(
      :provider => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit overlay form" do
    render

    assert_select "form[action=?][method=?]", overlay_path(@overlay), "post" do

      assert_select "input[name=?]", "overlay[provider_id]"

      assert_select "input[name=?]", "overlay[name]"
    end
  end
end
