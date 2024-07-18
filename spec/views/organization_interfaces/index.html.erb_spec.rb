require 'rails_helper'

RSpec.describe "organization_interfaces/index", type: :view do
  before(:each) do
    assign(:organization_interfaces, [
      OrganizationInterface.create!(
        :interface => nil,
        :organization => nil
      ),
      OrganizationInterface.create!(
        :interface => nil,
        :organization => nil
      )
    ])
  end

  it "renders a list of organization_interfaces" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
