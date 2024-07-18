require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_meter) { FactoryBot.create(:valid_meter,number: "14243784684") }

  before do 
  	customer.meters << valid_meter
  end

  describe "Showing previous token" do

	   it "Displays the last three tokens" do 
	   	    VCR.use_cassette("displaying_previous_3_tokens")  do 
			    post :index, params: { phoneNumber: customer.number,
				             serviceCode: "*384*2000#",
				             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
				             text: "1*2*1"}
			    expect(response.body).to eql("CON Last three tokens for Meter No:#{valid_meter.number}\n1: 48733723248670831203\n2: 35213959753515694523\n3: 48359472762309551108\n\n\n0:Back 00:Home")  
 		    end
	    end

	   # it "Sends sms with the last token" do 
	   #   	VCR.use_cassette("sends_last_token_sms")  do 
			 #    post :index, params: { phoneNumber: customer.number,
				#              serviceCode: "*384*2000#",
				#              sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
				#              text: "1*2*1"}
			 #    message = Message.last
			 #    expect(message.content).to eql(nil)
			 #    expect(message.code).to eql(nil)
			 #    expect(message.customer).to eql(customer)
			 #    expect(message.messageable).to eql(valid_meter)
			 #    expect(message.service).to eql("prepaid_token")
	 		#     expect(MessageWorker).to have_enqueued_sidekiq_job(message.id)
	 		#     MessageWorker.drain
	 		#     message.reload
	 		#     expect(message.content).to eql("Your last token number is 48733723248670831203")
			 #    expect(message.code).to eql("200")
			 #    expect(message.customer).to eql(customer)
			 #    expect(message.messageable).to eql(valid_meter)
			 #    expect(message.service).to eql("prepaid_token")
 		 #    end
	   #  end

	      it "Informs customer when meter number is wrong" do 
	     	VCR.use_cassette("wrong_meter_number")  do 
			    post :index, params: { phoneNumber: customer.number,
				             serviceCode: "*384*2000#",
				             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
				             text: "1*2*2*24689546789"}
			    expect(response.body).to eql("CON The meter sereial number doesn't exist.\n\n0:Back 00:Home")  
			    # message = Message.last
			    # expect(message.content).to eql(nil)
			    # expect(message.code).to eql(nil)
			    # expect(message.customer).to eql(customer)
			    # expect(message.service).to eql("prepaid_token")
	 		   #  expect(MessageWorker).to have_enqueued_sidekiq_job(message.id)
	 		   #  MessageWorker.drain
	 		   #  message.reload
	 		   #  expect(message.content).to eql("The meter serial number doesn't exist.")
			    # expect(message.code).to eql("200")
			    # expect(message.customer).to eql(customer)
			    # expect(message.service).to eql("prepaid_token")
 		    end
	    end

	end

end








