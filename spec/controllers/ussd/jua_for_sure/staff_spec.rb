require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:valid_account) { FactoryBot.build(:valid_account) }


  describe "Confirming staff spec" do
	 it "When network failure" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "4*1"}
	    expect(response.body).to eql("CON Enter 5 digit Staff Number\n\n0:Back 00:Home")    

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "4*1*76890"}
	    expect(response.body).to eql("CON The request could not be completed, try again later.\n\n0:Back 00:Home") 
	  end

	it "When is positive" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "4*1*87028"}
	    expect(response.body).to eql("CON The request could not be completed, try again later.\n\n0:Back 00:Home")       
	    
	 #    message = Message.last
		# expect(message.content).to eql("87028")
		# expect(message.code).to eql(nil)
		# expect(message.customer).to eql(customer)
		# expect(message.service).to eql("find_employee")
		# expect(MessageWorker).to have_enqueued_sidekiq_job(message.id)

	end

	it "When is of invalid format" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "4*1*768"}
	    expect(response.body).to eql("CON Staff number is of invalid format.\n\n0:Back 00:Home")       
	end
  end

end
