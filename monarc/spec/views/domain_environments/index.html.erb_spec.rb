require 'rails_helper'

RSpec.describe "domain_environments/index", type: :view do
  before(:each) do
    assign(:domain_environments, [
      DomainEnvironment.create!(
        :name => "Name",
        :description => "Description",
        :data_classification => "Data Classification",
        :organization => nil
      ),
      DomainEnvironment.create!(
        :name => "Name",
        :description => "Description",
        :data_classification => "Data Classification",
        :organization => nil
      )
    ])
  end

  it "renders a list of domain_environments" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Data Classification".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
