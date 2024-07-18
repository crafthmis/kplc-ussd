require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:valid_account) { FactoryBot.build(:valid_account) }


  describe "Confirming contractor spec" do
	 it "When network failure" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "4*2"}
	    expect(response.body).to eql("CON Enter National ID\n\n0:Back 00:Home")    

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "4*2*76897876879"}
	    expect(response.body).to eql("CON The request could not be completed, try again later.\n\n0:Back 00:Home") 
	  end

	it "When correct" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "4*2*123456789"}
	    expect(response.body).to eql("CON The request could not be completed, try again later.\n\n0:Back 00:Home")       
	 #    message = Message.last
		# expect(message.content).to eql("123456789")
		# expect(message.code).to eql(nil)
		# expect(message.customer).to eql(customer)
		# expect(message.service).to eql("find_contractor")
		# expect(MessageWorker).to have_enqueued_sidekiq_job(message.id)
	end

	it "When wrong" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "4*2*1*4353"}
	    expect(response.body).to eql("null")       
	end
  end

end









