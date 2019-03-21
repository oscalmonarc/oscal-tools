require 'rails_helper'

RSpec.describe "domain_environments/edit", type: :view do
  before(:each) do
    @domain_environment = assign(:domain_environment, DomainEnvironment.create!(
      :name => "MyString",
      :description => "MyString",
      :data_classification => "MyString",
      :organization => nil
    ))
  end

  it "renders the edit domain_environment form" do
    render

    assert_select "form[action=?][method=?]", domain_environment_path(@domain_environment), "post" do

      assert_select "input[name=?]", "domain_environment[name]"

      assert_select "input[name=?]", "domain_environment[description]"

      assert_select "input[name=?]", "domain_environment[data_classification]"

      assert_select "input[name=?]", "domain_environment[organization_id]"
    end
  end
end
