require 'rails_helper'

RSpec.describe "organization_interfaces/new", type: :view do
  before(:each) do
    assign(:organization_interface, OrganizationInterface.new(
      :interface => nil,
      :organization => nil
    ))
  end

  it "renders new organization_interface form" do
    render

    assert_select "form[action=?][method=?]", organization_interfaces_path, "post" do

      assert_select "input[name=?]", "organization_interface[interface_id]"

      assert_select "input[name=?]", "organization_interface[organization_id]"
    end
  end
end
