require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:valid_meter) { FactoryBot.build(:valid_meter) }

  describe "Creating prepaid meters" do
	 it "With no linked accounts" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*1"}
	    expect(response.body).to eql("CON Input your meter number\n\n0:Back 00:Home")    

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*1*76897876879"}
	    expect(response.body).to eql("CON Meter No:76897876879 has been added to this profile.\n\n0:Back 00:Home") 
	    customer.reload 
	    expect(customer.meters.size).to eql(1)
	  end

	it "With a linked account" do 
		customer.meters << valid_meter 
		expect(customer.meters.size).to eql(1) 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*1*2"}
	    expect(response.body).to eql("CON Input your meter number\n\n0:Back 00:Home")

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*1*2*76876898709"}
	    expect(response.body).to eql("CON Meter No:76876898709 has been added to this profile.\n\n0:Back 00:Home")       
	    expect(customer.meters.size).to eql(2) 
	end

	it "Last method returns nil when user types more characters" do 
	    customer.meters << valid_meter

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*1*1*4353"}
	    expect(response.body).to eql("null")       
	end
  end


  describe "Removing prepaid meters" do
      before do 
      	customer.meters << valid_meter 
      end

	it "With a linked account" do
    	expect(customer.meters.size).to eql(1) 
		
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*1"}
	    expect(response.body).to eql("CON Select meter\n1:#{valid_meter.number}\n2:Add meter number\n\n0:Back 00:Home")
    
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*1*1"}
	    expect(response.body).to eql("CON Meter No:#{valid_meter.number} has been removed from this profile.\n\n0:Back 00:Home")       
	    expect(customer.meters.size).to eql(0)
	end


  end

end









