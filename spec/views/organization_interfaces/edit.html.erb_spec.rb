require 'rails_helper'

RSpec.describe "organization_interfaces/edit", type: :view do
  before(:each) do
    @organization_interface = assign(:organization_interface, OrganizationInterface.create!(
      :interface => nil,
      :organization => nil
    ))
  end

  it "renders the edit organization_interface form" do
    render

    assert_select "form[action=?][method=?]", organization_interface_path(@organization_interface), "post" do

      assert_select "input[name=?]", "organization_interface[interface_id]"

      assert_select "input[name=?]", "organization_interface[organization_id]"
    end
  end
end
