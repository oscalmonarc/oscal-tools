require 'rails_helper'

RSpec.describe "overlays/index", type: :view do
  before(:each) do
    assign(:overlays, [
      Overlay.create!(
        :provider => nil,
        :name => "Name"
      ),
      Overlay.create!(
        :provider => nil,
        :name => "Name"
      )
    ])
  end

  it "renders a list of overlays" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
