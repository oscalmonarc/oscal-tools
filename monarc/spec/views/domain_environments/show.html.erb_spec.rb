require 'rails_helper'

RSpec.describe "domain_environments/show", type: :view do
  before(:each) do
    @domain_environment = assign(:domain_environment, DomainEnvironment.create!(
      :name => "Name",
      :description => "Description",
      :data_classification => "Data Classification",
      :organization => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Data Classification/)
    expect(rendered).to match(//)
  end
end
