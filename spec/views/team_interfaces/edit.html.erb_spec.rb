require 'rails_helper'

RSpec.describe "team_interfaces/edit", type: :view do
  before(:each) do
    @team_interface = assign(:team_interface, TeamInterface.create!(
      :team => nil,
      :organization_interface => nil,
      :organization => nil
    ))
  end

  it "renders the edit team_interface form" do
    render

    assert_select "form[action=?][method=?]", team_interface_path(@team_interface), "post" do

      assert_select "input[name=?]", "team_interface[team_id]"

      assert_select "input[name=?]", "team_interface[organization_interface_id]"

      assert_select "input[name=?]", "team_interface[organization_id]"
    end
  end
end
