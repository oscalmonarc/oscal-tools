require 'rails_helper'

RSpec.describe "related_labels/show", type: :view do
  before(:each) do
    @related_label = assign(:related_label, RelatedLabel.create!(
      :Label => nil,
      :object_type => "Object Type",
      :object_id => "Object",
      :bigint => "Bigint"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Object Type/)
    expect(rendered).to match(/Object/)
    expect(rendered).to match(/Bigint/)
  end
end
