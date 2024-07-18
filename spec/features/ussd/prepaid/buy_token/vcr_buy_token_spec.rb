require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let!(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let!(:request) { FactoryBot.create(:request,customer: customer)}
  let!(:valid_meter) { FactoryBot.build(:valid_meter) }

  describe "User has no meter linked to phone number" do
	  it "accepts and links meter to customer and generates mpesa online checkout" do 
	  	VCR.use_cassette("first_online_checkout") do
		  	expect(Meter.count).to eql(0)
		  	expect(customer.meters.count).to eql(0)

		  	post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*1*#{valid_meter.number}"}    ####>>>>>.inputing a valid meter
		    expect(response.body).to eql("CON Enter Amount In Ksh\n\n0:Back 00:Home") 

		    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*1*#{valid_meter.number}*10"}    ####>>>>>.inputing a valid meter
		    expect(response.body).to eql("END You are being redirected to MPESA Menu")   
		    expect(Meter.count).to eql(1)
		    expect(customer.reload.meters.count).to eql(1)
		    mpesa = Mpesa.first
		    meter = Meter.first

		    expect(mpesa.merchant_request_id).to eql(nil)
		    expect(mpesa.checkout_request_id).to eql(nil)
		    expect(mpesa.customer_message).to eql(nil)
		    expect(mpesa.result_code).to eql(nil)
		    expect(mpesa.result_desc).to eql(nil)
		    expect(mpesa.amount).to eql("10")

		    expect(mpesa.mpesa_receipt_number).to eql(nil)
		    expect(mpesa.transaction_date).to eql(nil)
		    expect(mpesa.customer).to eql(customer)
		    expect(mpesa.mpesable).to eql(meter)

		    expect(MpesaWorker).to have_enqueued_sidekiq_job(mpesa.id)
		    MpesaWorker.drain

		    mpesa.reload

		    expect(mpesa.merchant_request_id).to eql("30176-14023343-1")
		    expect(mpesa.checkout_request_id).to eql("ws_CO_240220202125046334")
		    expect(mpesa.customer_message).to eql("Success. Request accepted for processing")
		    expect(mpesa.result_code).to eql(nil)
		    expect(mpesa.result_desc).to eql(nil)
		    expect(mpesa.amount).to eql("10")

		    expect(mpesa.mpesa_receipt_number).to eql(nil)
		    expect(mpesa.transaction_date).to eql(nil)
		    expect(mpesa.customer).to eql(customer)
		    expect(mpesa.mpesable).to eql(meter)
	    end
	  end
	end

end






