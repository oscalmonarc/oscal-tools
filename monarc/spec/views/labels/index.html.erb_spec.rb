require 'rails_helper'

RSpec.describe "labels/index", type: :view do
  before(:each) do
    assign(:labels, [
      Label.create!(
        :name => "Name",
        :description => "Description"
      ),
      Label.create!(
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of labels" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
