require 'rails_helper'

RSpec.describe "confirmations/index", type: :view do
  before(:each) do
    assign(:confirmations, [
      Confirmation.create!(
        :seqnum => 2,
        :billrefnumber => "Billrefnumber",
        :transamount => "Transamount",
        :transid => "Transid",
        :transtype => "Transtype",
        :kptransid => "Kptransid",
        :mobilenumber => "Mobilenumber",
        :invoicenumber => "Invoicenumber",
        :messages => "Messages",
        :status => "Status",
        :lastamount => 3,
        :messageid => "Messageid",
        :method => "9.99",
        :userid => "Userid"
      ),
      Confirmation.create!(
        :seqnum => 2,
        :billrefnumber => "Billrefnumber",
        :transamount => "Transamount",
        :transid => "Transid",
        :transtype => "Transtype",
        :kptransid => "Kptransid",
        :mobilenumber => "Mobilenumber",
        :invoicenumber => "Invoicenumber",
        :messages => "Messages",
        :status => "Status",
        :lastamount => 3,
        :messageid => "Messageid",
        :method => "9.99",
        :userid => "Userid"
      )
    ])
  end

  it "renders a list of confirmations" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Billrefnumber".to_s, :count => 2
    assert_select "tr>td", :text => "Transamount".to_s, :count => 2
    assert_select "tr>td", :text => "Transid".to_s, :count => 2
    assert_select "tr>td", :text => "Transtype".to_s, :count => 2
    assert_select "tr>td", :text => "Kptransid".to_s, :count => 2
    assert_select "tr>td", :text => "Mobilenumber".to_s, :count => 2
    assert_select "tr>td", :text => "Invoicenumber".to_s, :count => 2
    assert_select "tr>td", :text => "Messages".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Messageid".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Userid".to_s, :count => 2
  end
end
