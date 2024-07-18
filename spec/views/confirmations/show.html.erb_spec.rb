require 'rails_helper'

RSpec.describe "confirmations/show", type: :view do
  before(:each) do
    @confirmation = assign(:confirmation, Confirmation.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Billrefnumber/)
    expect(rendered).to match(/Transamount/)
    expect(rendered).to match(/Transid/)
    expect(rendered).to match(/Transtype/)
    expect(rendered).to match(/Kptransid/)
    expect(rendered).to match(/Mobilenumber/)
    expect(rendered).to match(/Invoicenumber/)
    expect(rendered).to match(/Messages/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Messageid/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Userid/)
  end
end
