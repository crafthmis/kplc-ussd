require 'rails_helper'

RSpec.describe "equities/index", type: :view do
  before(:each) do
    assign(:equities, [
      Equity.create!(
        :customer => nil,
        :amount => "Amount",
        :status => "Status",
        :equitable => nil
      ),
      Equity.create!(
        :customer => nil,
        :amount => "Amount",
        :status => "Status",
        :equitable => nil
      )
    ])
  end

  it "renders a list of equities" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Amount".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
