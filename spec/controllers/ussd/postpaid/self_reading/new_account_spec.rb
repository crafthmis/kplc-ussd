require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_account) { FactoryBot.build(:valid_account) }


    describe "When there is no linked account" do
	  it "User selects existing meter and inputs reading" do 
	  	VCR.use_cassette("self_reading/new_account")  do 
	  	expect(customer.accounts.count).to eql(0)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*4"}
	    expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")       

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*4*#{valid_account.number}"}
	    expect(response.body).to eql("CON Enter your meter reading\n\n0:Back 00:Home")  

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*4*#{valid_account.number}*76578"}
	    expect(response.body).to eql("CON Your reading has been captured.\n\n0:Back 00:Home")   
		reading = Reading.first
		expect(customer.readings.count).to eql(1)
		expect(reading.number).to eql("76578")
	    end
	  end
  end


end









