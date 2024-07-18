require 'rails_helper'

RSpec.describe "equities/show", type: :view do
  before(:each) do
    @equity = assign(:equity, Equity.create!(
      :customer => nil,
      :amount => "Amount",
      :status => "Status",
      :equitable => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Amount/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(//)
  end
end
