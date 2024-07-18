require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do

  describe "Confirming contractor spec" do

	it "When is positive" do 
		VCR.use_cassette("correct_contractor_spec")  do 
		    post :index, params: { phoneNumber: "254712829808",
			             serviceCode: "*384*2000#",
			             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
			             text: "4*2*12345678"}
			customer = Customer.first
			customer.stub(:find_contractor).and_return("aodfdas")
		    expect(response.body).to eql("CON ID NO.12345678,TEST is a Kenya Power Contractor.\n\n0:Back 00:Home")       

		 #    message = Message.last
		 #    customer = Customer.first
			# expect(message.content).to eql("12345678")
			# expect(message.code).to eql(nil)
			# expect(message.customer).to eql(customer)
			# expect(message.service).to eql("find_contractor")
			# expect(MessageWorker).to have_enqueued_sidekiq_job(message.id)

			# MessageWorker.drain
			# message.reload
			# expect(message.content).to eql("ID NO.12345678,TEST is a Kenya Power Contractor.")
			# expect(message.code).to eql("200")
			# expect(message.customer).to eql(customer)
			# expect(message.messageable).to eql(customer)
	    end
	end

	it "When is negative" do 
		VCR.use_cassette("incorrect_contractor_spec")  do 
		    post :index, params: { phoneNumber: "254712829808",
			             serviceCode: "*384*2000#",
			             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
			             text: "4*2*12345"}
		    expect(response.body).to eql("CON ID NO.12345 is a fraudstar, report immediately on the Anti-Fraud Hotline Number: 0718-999-000\n\n0:Back 00:Home")       

		 #    message = Message.last
		 #    customer = Customer.first
			# expect(message.content).to eql("12345")
			# expect(message.code).to eql(nil)
			# expect(message.customer).to eql(customer)
			# expect(message.service).to eql("find_contractor")
			# expect(MessageWorker).to have_enqueued_sidekiq_job(message.id)

			# MessageWorker.drain
			# message.reload
			# expect(message.content).to eql("ID NO.12345 is a fraudstar, report immediately on the Anti-Fraud Hotline Number: 0718-999-000")
			# expect(message.code).to eql("200")
			# expect(message.customer).to eql(customer)
			# expect(message.messageable).to eql(customer)
	    end
	end


  end

end
