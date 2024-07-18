require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_meter) { FactoryBot.create(:valid_meter) }

  before do 
  	customer.meters << valid_meter
  end

  describe "User has meter linked to phone number" do
	  it "It displays the list of saved meters" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2"}
	    expect(response.body).to eql("CON Select meter\n1:#{valid_meter.number}\n2:Add meter number\n\n0:Back 00:Home")       
	  end

	  it "Can add a new meter number" do   ##the number two is more than the current saved meters hence systme sees that the user intends to add a meter
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*2"}
	    expect(response.body).to eql("CON Input your meter number\n\n0:Back 00:Home")       
	  end

	   it "Does not enter into non existent last method" do 
	  	expect(Meter.count).to eql(1)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*2*12345678901*20"}
	    expect(response.body).to eql("null")       
	  end

	   it "adds a meter with valid numbers" do 
	  	expect(Meter.count).to eql(1)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*2*12345678901"}
	    expect(Meter.count).to eql(2)      
	  end



	  it "Displays error when network is unreachable" do 
	  	expect(Meter.count).to eql(1)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*2*12345678901"}
	    expect(response.body).to eql("CON The transaction took too long to complete, kindly try again.\n\n0:Back 00:Home") 
	  end


	  it "does not add a meter with few numbers" do 
	  	expect(Meter.count).to eql(1)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*2*1234678987"}
	    expect(response.body).to eql("CON The meter number entered is incorrect.\n\n0:Back 00:Home") 
	    expect(Meter.count).to eql(1)      
	  end


	  it "does not add a meter number with more numbers" do 
	  	expect(Meter.count).to eql(1)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*2*12346789873434"}
	    expect(response.body).to eql("CON The meter number entered is incorrect.\n\n0:Back 00:Home")    
	    expect(Meter.count).to eql(1)    
	  end


	  it "Queues SMS when you check the last token" do 
		post :index, params: { phoneNumber: customer.number,
		     serviceCode: "*384*2000#",
		     sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		     text: "1*2*1"}
		message = Message.last
		expect(message.content).to eql(nil)
		expect(message.code).to eql(nil)
		expect(message.customer).to eql(customer)
		expect(message.messageable).to eql(valid_meter)
		expect(message.service).to eql("prepaid_token")
	  end


	  it "returns null when non existent last method is reached after adding a meter" do 
	  	expect(Meter.count).to eql(1)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*2*12346789873434*20"}
	    expect(response.body).to eql("null")    
	    expect(Meter.count).to eql(1)    
	  end


	  it "Returns null when last method reached after selecting stored meters" do 
		post :index, params: { phoneNumber: customer.number,
		     serviceCode: "*384*2000#",
		     sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		     text: "1*2*1*20"}
		expect(response.body).to eql("null")
	  end

  end
end









