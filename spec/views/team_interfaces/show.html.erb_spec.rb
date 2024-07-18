require 'rails_helper'

RSpec.describe "team_interfaces/show", type: :view do
  before(:each) do
    @team_interface = assign(:team_interface, TeamInterface.create!(
      :team => nil,
      :organization_interface => nil,
      :organization => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
