require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808")}
  let(:valid_account) { FactoryBot.build(:valid_account) }


  describe "Reporting postpaid accounts" do


	it "report postpaid failure" do 
		VCR.use_cassette("postpaid_report_failure")  do 
		    customer.accounts << valid_account 
		    post :index, params: { phoneNumber: customer.number,
			             serviceCode: "*384*2000#",
			             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
			             text: "3*2"}
		    expect(response.body).to eql("CON Select account\n1:#{valid_account.number}\n2:Add account number\n\n0:Back 00:Home") 

		    post :index, params: { phoneNumber: customer.number,
			             serviceCode: "*384*2000#",
			             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
			             text: "3*2*1"}
		    expect(response.body).to eql("CON A new complaint with the referrence 5269556 has been logged for account no: 47042221\n\n0:Back 00:Home")       
	    end
	end

  end
end









