require 'rails_helper'

RSpec.describe "components/show", type: :view do
  before(:each) do
    @component = assign(:component, Component.create!(
      :provider => nil,
      :component_type => nil,
      :name => "Name",
      :description => "Description",
      :make => "Make",
      :model => "Model",
      :version => "Version"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Make/)
    expect(rendered).to match(/Model/)
    expect(rendered).to match(/Version/)
  end
end
