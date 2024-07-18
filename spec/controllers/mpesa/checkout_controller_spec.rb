require 'rails_helper'

RSpec.describe Api::V1::MpesaController, type: :controller do


 describe "Mpesa callback url for online checkout" do
 	let!(:customer) { FactoryBot.create(:customer)}
 	let!(:meter) {FactoryBot.create(:meter)}
 	let!(:mpesa) { FactoryBot.create(:mpesa,customer: customer,mpesable: meter )}

	  it "When payment is successful" do 
	    post :checkout_callback,params: {
										    "Body": {
										        "stkCallback": {
										            "MerchantRequestID": mpesa.merchant_request_id,
										            "CheckoutRequestID": "ws_CO_260220202316008498",
										            "ResultCode": 0,
										            "ResultDesc": "The service request is processed successfully.",
										            "CallbackMetadata": {
										                "Item": [
										                    {
										                        "Name": "Amount",
										                        "Value": 1
										                    },
										                    {
										                        "Name": "MpesaReceiptNumber",
										                        "Value": "OBQ3D81FO7"
										                    },
										                    {
										                        "Name": "Balance"
										                    },
										                    {
										                        "Name": "TransactionDate",
										                        "Value": 20200226231535
										                    },
										                    {
										                        "Name": "PhoneNumber",
										                        "Value": 254712829808
										                    }
										                ]
										            }
										        }
										    }
										}
 
		expect(response.status).to eql(204)  
		mpesa.reload
		expect(mpesa.result_code).to eql("0")
		expect(mpesa.result_desc).to eql("The service request is processed successfully.")
		expect(mpesa.mpesa_receipt_number).to eql("OBQ3D81FO7")
		expect(mpesa.transaction_date).to eql("20200226231535")
	  end

	  it "When payment is cancelled it finds and edits the mpesa using MerchantRequestID" do
	  	expect(mpesa.result_code).to eql("0")
	  	expect(mpesa.result_desc).to eql("Success Request accepted for processing")

	    post :checkout_callback,params: {
										    "Body": {
										        "stkCallback": {
										            "MerchantRequestID": mpesa.merchant_request_id,
										            "CheckoutRequestID": "ws_CO_240220202125046334",
										            "ResultCode": 1032,
										            "ResultDesc": "Request cancelled by user"
										        }
										    }
										}
	    expect(response.status).to eql(204)  
	    mpesa.reload
	    expect(mpesa.result_code).to eql("1032")
	  	expect(mpesa.result_desc).to eql("Request cancelled by user")
	  end
 end


end

