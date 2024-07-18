require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_account) { FactoryBot.create(:valid_account) }

  before do 
  	customer.accounts << valid_account
  end

  describe "User has account linked to phone number" do

	  it "Checks users postpaid bill" do 
	  	VCR.use_cassette("postpaid/current_bill/check_postpaid_bill")  do 
		    post :index, params: { phoneNumber: customer.number,
					     serviceCode: "*384*2000#",
					     sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
					     text: "2*1*1" }

		    expect(response.body).to eql("CON Account: 47042221\n Name: ROBERT JALLANG&apos;O AKELLO\n Balance: -1.33 Ksh Overpayment\nLatest Bill: 615 Ksh\n Due Date: 2020-03-06\n\n0:Back 00:Home")  
		end
	  end

	  it "Queues SMS when you query bill and sends sms" do 
	  	pending("network connection")
	  	VCR.use_cassette("postpaid/current_bill/queue_sms")  do 
		    post :index, params: { phoneNumber: customer.number,
					     serviceCode: "*384*2000#",
					     sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
					     text: "2*1*1" }

		    message = Message.last
		    expect(message.content).to eql(nil)
		    expect(message.code).to eql(nil)
		    expect(message.customer).to eql(customer)
		    expect(message.service).to eql("postpaid_balance")
 		    expect(MessageWorker).to have_enqueued_sidekiq_job(message.id)
 		    MessageWorker.drain
 		    message.reload
 		    expect(message.content).to eql("CON Account: 47042221\n Name: ROBERT JALLANG&apos;O AKELLO\n Balance: -1.33 Ksh Overpayment\nLatest Bill: 615 Ksh\n Due Date: 2020-03-06\n\n0:Back 00:Home")
		    expect(message.code).to eql("200")
		    expect(message.customer).to eql(customer)
		    expect(message.service).to eql("prepaid_token")
		end
	  end

	  it "When the account number is wrong" do 
	  	VCR.use_cassette("postpaid/current_bill/wrong_account")  do 
	    post :index, params: { phoneNumber: customer.number,
				     serviceCode: "*384*2000#",
				     sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
				     text: "2*1*243243" }

		expect(response.body).to eql("CON Account: 47042221\n Name: ROBERT JALLANG&apos;O AKELLO\n Balance: -1.33 Ksh Overpayment\nLatest Bill: 615 Ksh\n Due Date: 2020-03-06\n\n0:Back 00:Home")  
		message = Message.last
		expect(message.content).to eql(nil)
		expect(message.code).to eql(nil)
		expect(message.customer).to eql(customer)
		expect(message.service).to eql("postpaid_balance")
		expect(MessageWorker).to have_enqueued_sidekiq_job(message.id)
		MessageWorker.drain
		message.reload
		expect(message.content).to eql("The meter serial number doesn't exist.")
		expect(message.code).to eql("200")
		expect(message.customer).to eql(customer)
		expect(message.service).to eql("prepaid_token")
		end
	  end

  end
end
