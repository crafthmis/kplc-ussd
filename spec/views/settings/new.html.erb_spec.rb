require 'rails_helper'

RSpec.describe "settings/new", type: :view do
  before(:each) do
    assign(:setting, Setting.new(
      :ussd_sms => false,
      :prepaid_token => false,
      :postpaid_token => false,
      :find_contractor => false,
      :find_employee => false,
      :short_code => false
    ))
  end

  it "renders new setting form" do
    render

    assert_select "form[action=?][method=?]", settings_path, "post" do

      assert_select "input[name=?]", "setting[ussd_sms]"

      assert_select "input[name=?]", "setting[prepaid_token]"

      assert_select "input[name=?]", "setting[postpaid_token]"

      assert_select "input[name=?]", "setting[find_contractor]"

      assert_select "input[name=?]", "setting[find_employee]"

      assert_select "input[name=?]", "setting[short_code]"
    end
  end
end
