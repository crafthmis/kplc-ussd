require 'rails_helper'

RSpec.describe "team_interfaces/new", type: :view do
  before(:each) do
    assign(:team_interface, TeamInterface.new(
      :team => nil,
      :organization_interface => nil,
      :organization => nil
    ))
  end

  it "renders new team_interface form" do
    render

    assert_select "form[action=?][method=?]", team_interfaces_path, "post" do

      assert_select "input[name=?]", "team_interface[team_id]"

      assert_select "input[name=?]", "team_interface[organization_interface_id]"

      assert_select "input[name=?]", "team_interface[organization_id]"
    end
  end
end
