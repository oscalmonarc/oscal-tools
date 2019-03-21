require 'rails_helper'

RSpec.describe "overlay_fields/index", type: :view do
  before(:each) do
    assign(:overlay_fields, [
      OverlayField.create!(
        :overlay => "",
        :name => "Name"
      ),
      OverlayField.create!(
        :overlay => "",
        :name => "Name"
      )
    ])
  end

  it "renders a list of overlay_fields" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
