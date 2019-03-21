require 'rails_helper'

RSpec.describe "data_classifications/show", type: :view do
  before(:each) do
    @data_classification = assign(:data_classification, DataClassification.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
