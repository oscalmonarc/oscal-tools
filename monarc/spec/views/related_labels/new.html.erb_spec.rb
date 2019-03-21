require 'rails_helper'

RSpec.describe "related_labels/new", type: :view do
  before(:each) do
    assign(:related_label, RelatedLabel.new(
      :Label => nil,
      :object_type => "MyString",
      :object_id => "MyString",
      :bigint => "MyString"
    ))
  end

  it "renders new related_label form" do
    render

    assert_select "form[action=?][method=?]", related_labels_path, "post" do

      assert_select "input[name=?]", "related_label[Label_id]"

      assert_select "input[name=?]", "related_label[object_type]"

      assert_select "input[name=?]", "related_label[object_id]"

      assert_select "input[name=?]", "related_label[bigint]"
    end
  end
end
