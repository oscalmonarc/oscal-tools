require 'rails_helper'

RSpec.describe "component_domains/new", type: :view do
  before(:each) do
    assign(:component_domain, ComponentDomain.new(
      :component => nil,
      :domain_environment => nil
    ))
  end

  it "renders new component_domain form" do
    render

    assert_select "form[action=?][method=?]", component_domains_path, "post" do

      assert_select "input[name=?]", "component_domain[component_id]"

      assert_select "input[name=?]", "component_domain[domain_environment_id]"
    end
  end
end
