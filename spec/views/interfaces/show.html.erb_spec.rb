require 'rails_helper'

RSpec.describe "interfaces/show", type: :view do
  before(:each) do
    @interface = assign(:interface, Interface.create!(
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end
