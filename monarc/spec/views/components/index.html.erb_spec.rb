require 'rails_helper'

RSpec.describe "components/index", type: :view do
  before(:each) do
    assign(:components, [
      Component.create!(
        :provider => nil,
        :component_type => nil,
        :name => "Name",
        :description => "Description",
        :make => "Make",
        :model => "Model",
        :version => "Version"
      ),
      Component.create!(
        :provider => nil,
        :component_type => nil,
        :name => "Name",
        :description => "Description",
        :make => "Make",
        :model => "Model",
        :version => "Version"
      )
    ])
  end

  it "renders a list of components" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Make".to_s, :count => 2
    assert_select "tr>td", :text => "Model".to_s, :count => 2
    assert_select "tr>td", :text => "Version".to_s, :count => 2
  end
end
