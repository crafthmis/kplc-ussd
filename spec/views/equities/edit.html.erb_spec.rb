require 'rails_helper'

RSpec.describe "equities/edit", type: :view do
  before(:each) do
    @equity = assign(:equity, Equity.create!(
      :customer => nil,
      :amount => "MyString",
      :status => "MyString",
      :equitable => nil
    ))
  end

  it "renders the edit equity form" do
    render

    assert_select "form[action=?][method=?]", equity_path(@equity), "post" do

      assert_select "input[name=?]", "equity[customer_id]"

      assert_select "input[name=?]", "equity[amount]"

      assert_select "input[name=?]", "equity[status]"

      assert_select "input[name=?]", "equity[equitable_id]"
    end
  end
end
