require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_account) { FactoryBot.build(:valid_account) }


  describe "When there is linked account" do
  	 before do 
	  	customer.accounts << valid_account
	  end
	  it "Accounts are linked and reading accepted" do 
	  	expect(customer.accounts.count).to eql(1)
	  	expect(customer.readings.count).to eql(0)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*4"}
	    expect(response.body).to eql("CON Select account\n1:#{valid_account.number}\n2:Add account number\n\n0:Back 00:Home")       

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*4*1"}
	    expect(response.body).to eql("CON Enter your meter reading\n\n0:Back 00:Home")  

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*4*1*768742"}
	    expect(response.body).to eql("CON Your reading has been captured.\n\n0:Back 00:Home")   
		reading = Reading.last
		customer.reload
		expect(customer.readings.count).to eql(1)	 ##TODO: Find why two records are created
		expect(reading.number).to eql("768742")
		expect(reading.account).to eql(valid_account)
	 end
  end

end









