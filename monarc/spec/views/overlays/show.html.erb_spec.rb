require 'rails_helper'

RSpec.describe "overlays/show", type: :view do
  before(:each) do
    @overlay = assign(:overlay, Overlay.create!(
      :provider => nil,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
  end
end
