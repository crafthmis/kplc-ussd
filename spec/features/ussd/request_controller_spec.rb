require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let!(:request) { FactoryBot.build(:request)}
  let!(:customer) { request.customer }

 describe "When users dial the ussd" do
	  it "the current request is saved by sidekiq background job" do 
	  	expect(Request.count).to eql(0)
	    post :index, params: { phoneNumber: customer.number,
	             serviceCode: "*384*2000#",
	             sessionId: request.session_id,
	             text: "2"}
	    
	    cus = Customer.first

	    expect(RequestWorker).to have_enqueued_sidekiq_job(request.session_id,customer.number,request.text,"2",cus.id)
	    RequestWorker.drain
	    expect(Request.count).to eql(1)
	    req = Request.first
	    
	    expect(req.text).to eql("2")
	    expect(req.session_id).to eql(request.session_id)
	    expect(req.kind).to eql(nil)
	    expect(req.customer).to eql(cus)
	  end

	  it "only one request is created per session id" do 
	  	expect(Request.count).to eql(0)
	    post :index, params: { phoneNumber: request.customer.number,
	             serviceCode: "*384*2000#",
	             sessionId: request.session_id,
	             text: ""}
	    cus = Customer.first

  	    expect(RequestWorker).to have_enqueued_sidekiq_job(request.session_id,customer.number,request.text,"",cus.id)
  	    RequestWorker.drain
        expect(Request.count).to eql(1)
	    post :index, params: { phoneNumber: request.customer.number,
	             serviceCode: "*384*2000#",
	             sessionId: request.session_id,
	             text: "1"}

	    expect(RequestWorker).to have_enqueued_sidekiq_job(request.session_id,customer.number,"1","",cus.id)
  	    RequestWorker.drain

	    expect(Request.count).to eql(1)
	  end

	  it "It uses the params['USSD_STRING'] to differentiate vendor safaricom and sets other parameters appropriately" do 
	  	expect(Request.count).to eql(0)
	    post :index, params: { MSISDN: "2547354897",
	             serviceCode: "*384*2000#",
	             SESSION_ID: "ATUid_26814e5e9dd5dda7b0046affa1e0a873",
	             USSD_STRING: ""}
	    cus = Customer.first

  	    expect(RequestWorker).to have_enqueued_sidekiq_job("ATUid_26814e5e9dd5dda7b0046affa1e0a873","2547354897","","saf_ussd",cus.id)
  	    RequestWorker.drain
  	    req = Request.last
  	    expect(req.text).to eql("")
	    expect(req.session_id).to eql("ATUid_26814e5e9dd5dda7b0046affa1e0a873")
	    expect(req.kind).to eql("saf_ussd")
	    expect(req.customer).to eql(cus)
	  end

	end
end
 

