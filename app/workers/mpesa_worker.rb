class MpesaWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(mpesa_id)
  # 		mpesa = Mpesa.find(mpesa_id)
		# service =  if mpesa.mpesable_type == "Meter"
		# 	            "prepaid"
		# 	  		else
		# 	  			"postpaid"
		# 	  		end

  # 		customer = mpesa.customer
  # 		amount = mpesa.amount
  # 		meter = mpesa.mpesable.number
		# credentials = Base64.encode64(ENV["#{service}_token"]).gsub("\n", "")
		# response = HTTParty.get(ENV['auth_generator'], :headers =>{ "Content-Type" => "application/json", "Authorization" => "Basic #{credentials}"}, :query => { "grant_type" => "client_credentials"})#puts response
		# auth_token = JSON.parse(response.body)["access_token"]
		# business_code = ENV["#{service}_code"]
		# endpoint = ENV['checkout_url']  
		# phone = customer.number.split(//).last(12).join
		# timestamp = Time.now.strftime("%Y%m%d%H%M%S")
		# key = ENV["#{service}_online_pass_key"]
		# st = business_code + key + timestamp
		# passkey = Base64.encode64(st).gsub("\n", "")
		# request_body = {
		# 			      "BusinessShortCode": business_code,
		# 			      "Password": passkey,
		# 			      "Timestamp": timestamp,
		# 			      "TransactionType": "CustomerPayBillOnline",
		# 			      "Amount": amount,
		# 			      "PartyA": phone,
		# 			      "PartyB": business_code,
		# 			      "PhoneNumber": phone,
		# 			      "CallBackURL": ENV["checkout_callback_url"],
		# 			      "AccountReference": meter,
		# 			      "TransactionDesc": ENV["#{service}_transaction_desc"] #SecureRandom.alphanumeric(13)
		# 			    }
		# headers = {
		# 	"Authorization" => "Bearer #{auth_token}",
		# 	"Content-Type" =>  "application/json",
			
		# }
		# response = HTTParty.post(endpoint,:headers => headers ,body: request_body.to_json , :verify => false)

  #       if response["MerchantRequestID"]
  #         mpesa.update_attributes(merchant_request_id: response["MerchantRequestID"],
		# 				          checkout_request_id: response["CheckoutRequestID"],
		# 				          result_code: response["ResultCode"],
		# 				          customer_message: response["CustomerMessage"],
		# 				          result_desc: response["ResultDesc"])
  #       end
	end
end

