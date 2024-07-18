require 'rails_helper'

RSpec.describe "team_interfaces/index", type: :view do
  before(:each) do
    assign(:team_interfaces, [
      TeamInterface.create!(
        :team => nil,
        :organization_interface => nil,
        :organization => nil
      ),
      TeamInterface.create!(
        :team => nil,
        :organization_interface => nil,
        :organization => nil
      )
    ])
  end

  it "renders a list of team_interfaces" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
