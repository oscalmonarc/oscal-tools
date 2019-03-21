require 'rails_helper'

RSpec.describe "components/new", type: :view do
  before(:each) do
    assign(:component, Component.new(
      :provider => nil,
      :component_type => nil,
      :name => "MyString",
      :description => "MyString",
      :make => "MyString",
      :model => "MyString",
      :version => "MyString"
    ))
  end

  it "renders new component form" do
    render

    assert_select "form[action=?][method=?]", components_path, "post" do

      assert_select "input[name=?]", "component[provider_id]"

      assert_select "input[name=?]", "component[component_type_id]"

      assert_select "input[name=?]", "component[name]"

      assert_select "input[name=?]", "component[description]"

      assert_select "input[name=?]", "component[make]"

      assert_select "input[name=?]", "component[model]"

      assert_select "input[name=?]", "component[version]"
    end
  end
end
