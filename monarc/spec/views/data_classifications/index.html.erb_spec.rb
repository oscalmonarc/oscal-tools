require 'rails_helper'

RSpec.describe "data_classifications/index", type: :view do
  before(:each) do
    assign(:data_classifications, [
      DataClassification.create!(
        :name => "Name"
      ),
      DataClassification.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of data_classifications" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
