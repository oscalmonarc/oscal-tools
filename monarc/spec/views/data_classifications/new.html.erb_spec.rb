require 'rails_helper'

RSpec.describe "data_classifications/new", type: :view do
  before(:each) do
    assign(:data_classification, DataClassification.new(
      :name => "MyString"
    ))
  end

  it "renders new data_classification form" do
    render

    assert_select "form[action=?][method=?]", data_classifications_path, "post" do

      assert_select "input[name=?]", "data_classification[name]"
    end
  end
end
