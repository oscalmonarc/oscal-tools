require 'rails_helper'

RSpec.describe "component_domains/index", type: :view do
  before(:each) do
    assign(:component_domains, [
      ComponentDomain.create!(
        :component => nil,
        :domain_environment => nil
      ),
      ComponentDomain.create!(
        :component => nil,
        :domain_environment => nil
      )
    ])
  end

  it "renders a list of component_domains" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
