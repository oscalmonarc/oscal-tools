require 'rails_helper'

RSpec.describe "overlay_field_options/index", type: :view do
  before(:each) do
    assign(:overlay_field_options, [
      OverlayFieldOption.create!(
        :overlay_field => nil,
        :name => "Name"
      ),
      OverlayFieldOption.create!(
        :overlay_field => nil,
        :name => "Name"
      )
    ])
  end

  it "renders a list of overlay_field_options" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
