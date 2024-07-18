require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let!(:customer) { FactoryBot.create(:customer)}
  let!(:request) { FactoryBot.build(:request,customer: customer)}

 describe "When users dial ussd" do
	  it "Saves first time users" do 
	  	expect(Customer.count).to eql(1)
	    post :index, params: { phoneNumber: '+254712739409',
	             serviceCode: "*384*2000#",
	             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             text: ""}
	    expect(Customer.count).to eql(2)

	  end

	  it "reloads customers who already exist" do 
	  	expect(Customer.count).to eql(1)
	    post :index, params: { phoneNumber: customer.number,
	             serviceCode: "*384*2000#",
	             sessionId: request.session_id,
	             text: request.text}
	             
	    expect(Customer.count).to eql(1)
	  end

	end
end

