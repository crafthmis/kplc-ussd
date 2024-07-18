require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_account) { FactoryBot.build(:valid_account) }


  describe "When there is no linked account" do
	  it "It displays the list of saved accounts" do 
	  	VCR.use_cassette("postpaid/pay_bill/new_user") do
	  	expect(customer.accounts.count).to eql(0)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*2"}
	    expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")       

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*2*#{valid_account.number}"}
	    expect(response.body).to eql("CON Enter amount to pay\n\n0:Back 00:Home")  

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*2*#{valid_account.number}*20"}
	    expect(response.body).to eql("END You are being redirected to MPESA Menu")   
		mpesa = Mpesa.first
		expect(customer.accounts.count).to eql(1)
	    expect(MpesaWorker).to have_enqueued_sidekiq_job(mpesa.id)
	    end
	  end
  end

end









