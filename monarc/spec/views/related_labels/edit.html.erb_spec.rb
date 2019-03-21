require 'rails_helper'

RSpec.describe "related_labels/edit", type: :view do
  before(:each) do
    @related_label = assign(:related_label, RelatedLabel.create!(
      :Label => nil,
      :object_type => "MyString",
      :object_id => "MyString",
      :bigint => "MyString"
    ))
  end

  it "renders the edit related_label form" do
    render

    assert_select "form[action=?][method=?]", related_label_path(@related_label), "post" do

      assert_select "input[name=?]", "related_label[Label_id]"

      assert_select "input[name=?]", "related_label[object_type]"

      assert_select "input[name=?]", "related_label[object_id]"

      assert_select "input[name=?]", "related_label[bigint]"
    end
  end
end
