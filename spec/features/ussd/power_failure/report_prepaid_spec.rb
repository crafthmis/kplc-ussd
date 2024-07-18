require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:valid_meter) { FactoryBot.build(:valid_meter) }


  describe "Reporting prepaid meters" do
	 it "With no linked meters" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*1"}
	    expect(response.body).to eql("CON Input your meter number\n\n0:Back 00:Home")    

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*1*76897876879"}
	    expect(response.body).to eql("CON The transaction took too long to complete.\n\n0:Back 00:Home") 
	    customer.reload 
	    expect(customer.meters.count).to eql(1)
	  end

	it "With a linked meter" do 
	  customer.meters << valid_meter 

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*1"}
	    expect(response.body).to eql("CON Select meter\n1:#{valid_meter.number}\n2:Add meter number\n\n0:Back 00:Home") 

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*1*1"}
	    expect(response.body).to eql("CON The transaction took too long to complete.\n\n0:Back 00:Home")       
	end
  end

end









