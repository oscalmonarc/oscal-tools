require 'rails_helper'

RSpec.describe "control_implementations/index", type: :view do
  before(:each) do
    assign(:control_implementations, [
      ControlImplementation.create!(
        :component => nil,
        :domain_environment => nil,
        :provider => nil,
        :security_control => nil,
        :security_policy => nil,
        :responsibility => "Responsibility",
        :implementation_method => "",
        :required => false
      ),
      ControlImplementation.create!(
        :component => nil,
        :domain_environment => nil,
        :provider => nil,
        :security_control => nil,
        :security_policy => nil,
        :responsibility => "Responsibility",
        :implementation_method => "",
        :required => false
      )
    ])
  end

  it "renders a list of control_implementations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Responsibility".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
