require 'rails_helper'

RSpec.describe "data_classifications/edit", type: :view do
  before(:each) do
    @data_classification = assign(:data_classification, DataClassification.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit data_classification form" do
    render

    assert_select "form[action=?][method=?]", data_classification_path(@data_classification), "post" do

      assert_select "input[name=?]", "data_classification[name]"
    end
  end
end
