require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:account) { FactoryBot.build(:account) }
  let(:valid_account) { FactoryBot.build(:valid_account) }

  before do 
  	customer.accounts << account
  end
    describe "When adding an account" do
		 it "It displays the list of saved accounts" do 
		 	VCR.use_cassette("postpaid/pay_bill/adding_account") do
			    post :index, params: { phoneNumber: customer.number,
				             serviceCode: "*384*2000#",
				             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
				             text: "2*2*2"}
			    expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")       

			    post :index, params: { phoneNumber: customer.number,
				             serviceCode: "*384*2000#",
				             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
				             text: "2*2*2*#{valid_account.number}"}
			    expect(response.body).to eql("CON Enter amount to pay\n\n0:Back 00:Home")   

			    post :index, params: { phoneNumber: customer.number,
				             serviceCode: "*384*2000#",
				             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
				             text: "2*2*2*#{valid_account.number}*400"}
			    expect(response.body).to eql("END You are being redirected to MPESA Menu")   
			    customer.reload
			    expect(customer.mpesas.count).to eql(1)

			    mpesa = Mpesa.first
			    account = Account.last

		        expect(mpesa.result_desc).to eql(nil)
			    expect(mpesa.amount).to eql("400")

			    expect(mpesa.mpesa_receipt_number).to eql(nil)
			    expect(mpesa.transaction_date).to eql(nil)
			    expect(mpesa.customer).to eql(customer)
			    expect(mpesa.mpesable).to eql(account)

			    expect(MpesaWorker).to have_enqueued_sidekiq_job(mpesa.id)
			    MpesaWorker.drain

			    mpesa.reload

			    expect(mpesa.merchant_request_id).to eql("9836-37434626-1")
			    expect(mpesa.checkout_request_id).to eql("ws_CO_160320200002289785")
			    expect(mpesa.customer_message).to eql("Success. Request accepted for processing")
			    expect(mpesa.result_code).to eql(nil)
			    expect(mpesa.result_desc).to eql(nil)
			    expect(mpesa.amount).to eql("400")

			    expect(mpesa.mpesa_receipt_number).to eql(nil)
			    expect(mpesa.transaction_date).to eql(nil)
			    expect(mpesa.customer).to eql(customer)
			    expect(mpesa.mpesable).to eql(account)
		    end
		  end
     end

end









