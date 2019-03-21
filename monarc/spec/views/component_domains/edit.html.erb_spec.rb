require 'rails_helper'

RSpec.describe "component_domains/edit", type: :view do
  before(:each) do
    @component_domain = assign(:component_domain, ComponentDomain.create!(
      :component => nil,
      :domain_environment => nil
    ))
  end

  it "renders the edit component_domain form" do
    render

    assert_select "form[action=?][method=?]", component_domain_path(@component_domain), "post" do

      assert_select "input[name=?]", "component_domain[component_id]"

      assert_select "input[name=?]", "component_domain[domain_environment_id]"
    end
  end
end
