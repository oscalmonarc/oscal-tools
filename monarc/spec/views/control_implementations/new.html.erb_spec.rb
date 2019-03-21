require 'rails_helper'

RSpec.describe "control_implementations/new", type: :view do
  before(:each) do
    assign(:control_implementation, ControlImplementation.new(
      :component => nil,
      :domain_environment => nil,
      :provider => nil,
      :security_control => nil,
      :security_policy => nil,
      :responsibility => "MyString",
      :implementation_method => "",
      :required => false
    ))
  end

  it "renders new control_implementation form" do
    render

    assert_select "form[action=?][method=?]", control_implementations_path, "post" do

      assert_select "input[name=?]", "control_implementation[component_id]"

      assert_select "input[name=?]", "control_implementation[domain_environment_id]"

      assert_select "input[name=?]", "control_implementation[provider_id]"

      assert_select "input[name=?]", "control_implementation[security_control_id]"

      assert_select "input[name=?]", "control_implementation[security_policy_id]"

      assert_select "input[name=?]", "control_implementation[responsibility]"

      assert_select "input[name=?]", "control_implementation[implementation_method]"

      assert_select "input[name=?]", "control_implementation[required]"
    end
  end
end
