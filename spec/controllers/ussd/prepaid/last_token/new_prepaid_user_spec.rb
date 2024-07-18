require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:valid_meter) { FactoryBot.build(:valid_meter) }

  describe "User has no meter linked to phone number" do
	 it "Prompts user to input the meter number" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2"}
	    expect(response.body).to eql("CON Input your meter number\n\n0:Back 00:Home")       
	  end

	it "Displays error message when network is unreachable" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*#{valid_meter.number}"}
	    expect(response.body).to eql("CON The transaction took too long to complete, kindly try again.\n\n0:Back 00:Home")       
	end

	it "Links meter to profile" do 
        expect(customer.meters.count).to eql(0)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*#{valid_meter.number}"}
		meter = Meter.last
	    expect(meter.customers.first).to eql(customer)
	    expect(customer.meters.count).to eql(1)
	end

	it "Creates and Queues an SMS for last token" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*#{valid_meter.number}"}
        message = Message.last
        meter = Meter.last
	    expect(message.content).to eql(nil)
	    expect(message.code).to eql(nil)
	    expect(message.customer).to eql(customer)
	    expect(message.messageable).to eql(meter)
	    expect(message.service).to eql("prepaid_token")
	end

	 it "Users can not enter into non existent last method" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*#{valid_meter.number}*20"}
       expect(response.body).to eql("null") 
	end



	end
end









