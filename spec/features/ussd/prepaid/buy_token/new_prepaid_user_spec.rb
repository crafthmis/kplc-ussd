require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let!(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let!(:request) { FactoryBot.create(:request,customer: customer)}
  let!(:valid_meter) { FactoryBot.build(:valid_meter) }

  describe "User has no meter linked to phone number" do
	  it "Prompts user to input the meter number" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*1"}
	    expect(response.body).to eql("CON Input your meter number\n\n0:Back 00:Home")       
	  end

	  it "Meter number with less than 11 digits" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*1*577886"}
	    expect(response.body).to eql("CON The meter number entered is incorrect.\n\n0:Back 00:Home")       
	  end

	   it "Meter number with 11 digits prompts amount in Ksh" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*1*#{valid_meter.number}"}    ####>>>>>.inputing a valid meter
	    expect(response.body).to eql("CON Enter Amount In Ksh\n\n0:Back 00:Home")   
	  end


	end


end






