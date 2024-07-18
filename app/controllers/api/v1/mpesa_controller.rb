class Api::V1::MpesaController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def checkout_callback
    if params["Body"]
    	if params["Body"]["stkCallback"] && params["Body"]["stkCallback"]["CallbackMetadata"]
    		Mpesa.find_by(merchant_request_id: params["Body"]["stkCallback"]["MerchantRequestID"]).tap do |m|
          m.result_code = params["Body"]["stkCallback"]["ResultCode"]
          m.result_desc = params["Body"]["stkCallback"]["ResultDesc"]
          m.mpesa_receipt_number =  params["Body"]["stkCallback"]["CallbackMetadata"]["Item"][1]["Value"] 
          m.transaction_date = params["Body"]["stkCallback"]["CallbackMetadata"]["Item"][3]["Value"] 
          m.save!
        end

       elsif params["Body"]["stkCallback"]
         Mpesa.find_by(merchant_request_id: params["Body"]["stkCallback"]["MerchantRequestID"]).tap do |m|
          m.result_code = params["Body"]["stkCallback"]["ResultCode"]
          m.result_desc = params["Body"]["stkCallback"]["ResultDesc"]
          m.save!
         end
       end
    end
    head :no_content
  end

end



                      #customer_message: response["CustomerMessage"],
