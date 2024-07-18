require 'rails_helper'

RSpec.describe "settings/index", type: :view do
  before(:each) do
    assign(:settings, [
      Setting.create!(
        :ussd_sms => false,
        :prepaid_token => false,
        :postpaid_token => false,
        :find_contractor => false,
        :find_employee => false,
        :short_code => false
      ),
      Setting.create!(
        :ussd_sms => false,
        :prepaid_token => false,
        :postpaid_token => false,
        :find_contractor => false,
        :find_employee => false,
        :short_code => false
      )
    ])
  end

  it "renders a list of settings" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
