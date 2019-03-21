require 'rails_helper'

RSpec.describe "providers/index", type: :view do
  before(:each) do
    assign(:providers, [
      Provider.create!(
        :name => "Name",
        :location => "Location",
        :description => "Description",
        :org_type => "Org Type"
      ),
      Provider.create!(
        :name => "Name",
        :location => "Location",
        :description => "Description",
        :org_type => "Org Type"
      )
    ])
  end

  it "renders a list of providers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Org Type".to_s, :count => 2
  end
end
