require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  describe "When user selects postpaid option" do
	  it "It displays the postpaid menu" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2"}
	    expect(response.body).to eql("CON Select option \n1.My bill\n2.Pay bill\n3.Bill alerts\n4.Self reading\n\n00:Home")       
	  end
  end
end


