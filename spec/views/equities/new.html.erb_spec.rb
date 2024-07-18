require 'rails_helper'

RSpec.describe "equities/new", type: :view do
  before(:each) do
    assign(:equity, Equity.new(
      :customer => nil,
      :amount => "MyString",
      :status => "MyString",
      :equitable => nil
    ))
  end

  it "renders new equity form" do
    render

    assert_select "form[action=?][method=?]", equities_path, "post" do

      assert_select "input[name=?]", "equity[customer_id]"

      assert_select "input[name=?]", "equity[amount]"

      assert_select "input[name=?]", "equity[status]"

      assert_select "input[name=?]", "equity[equitable_id]"
    end
  end
end
