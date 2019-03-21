require 'rails_helper'

RSpec.describe "domain_environments/new", type: :view do
  before(:each) do
    assign(:domain_environment, DomainEnvironment.new(
      :name => "MyString",
      :description => "MyString",
      :data_classification => "MyString",
      :organization => nil
    ))
  end

  it "renders new domain_environment form" do
    render

    assert_select "form[action=?][method=?]", domain_environments_path, "post" do

      assert_select "input[name=?]", "domain_environment[name]"

      assert_select "input[name=?]", "domain_environment[description]"

      assert_select "input[name=?]", "domain_environment[data_classification]"

      assert_select "input[name=?]", "domain_environment[organization_id]"
    end
  end
end
