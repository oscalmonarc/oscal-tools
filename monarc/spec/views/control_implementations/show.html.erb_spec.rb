require 'rails_helper'

RSpec.describe "control_implementations/show", type: :view do
  before(:each) do
    @control_implementation = assign(:control_implementation, ControlImplementation.create!(
      :component => nil,
      :domain_environment => nil,
      :provider => nil,
      :security_control => nil,
      :security_policy => nil,
      :responsibility => "Responsibility",
      :implementation_method => "",
      :required => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Responsibility/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
