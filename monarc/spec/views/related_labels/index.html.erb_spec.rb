require 'rails_helper'

RSpec.describe "related_labels/index", type: :view do
  before(:each) do
    assign(:related_labels, [
      RelatedLabel.create!(
        :Label => nil,
        :object_type => "Object Type",
        :object_id => "Object",
        :bigint => "Bigint"
      ),
      RelatedLabel.create!(
        :Label => nil,
        :object_type => "Object Type",
        :object_id => "Object",
        :bigint => "Bigint"
      )
    ])
  end

  it "renders a list of related_labels" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Object Type".to_s, :count => 2
    assert_select "tr>td", :text => "Object".to_s, :count => 2
    assert_select "tr>td", :text => "Bigint".to_s, :count => 2
  end
end
