require 'rails_helper'

RSpec.describe "organization_interfaces/show", type: :view do
  before(:each) do
    @organization_interface = assign(:organization_interface, OrganizationInterface.create!(
      :interface => nil,
      :organization => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
