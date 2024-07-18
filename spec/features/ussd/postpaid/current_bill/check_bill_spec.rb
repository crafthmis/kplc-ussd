require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_account) { FactoryBot.create(:valid_account) }

  before do 
  	customer.accounts << valid_account
  end

  describe "User has account linked to phone number" do
	  it "Gets error when balance API can not be reached" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*1*1"}
	    expect(response.body).to eql("CON The transaction took too long to complete, kindly try again.\n\n0:Back 00:Home")       
	  end

	  it "Queues SMS when you query bill" do 
		post :index, params: { phoneNumber: customer.number,
		     serviceCode: "*384*2000#",
		     sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		     text: "2*1*1"}
		message = Message.last
		expect(message.content).to eql(nil)
		expect(message.code).to eql(nil)
		expect(message.customer).to eql(customer)
		expect(message.messageable).to eql(valid_account)
		expect(message.service).to eql("postpaid_balance")
		expect(MessageWorker).to have_enqueued_sidekiq_job(message.id)
	  end
  end

end









