require 'rails_helper'

RSpec.describe "incidences/show", type: :view do
  before(:each) do
    @incidence = assign(:incidence, Incidence.create!(
      :kind => "Kind",
      :explanation => "Explanation",
      :customer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Kind/)
    expect(rendered).to match(/Explanation/)
    expect(rendered).to match(//)
  end
end
