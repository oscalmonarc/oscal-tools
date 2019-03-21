require 'rails_helper'

RSpec.describe "component_domains/show", type: :view do
  before(:each) do
    @component_domain = assign(:component_domain, ComponentDomain.create!(
      :component => nil,
      :domain_environment => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
