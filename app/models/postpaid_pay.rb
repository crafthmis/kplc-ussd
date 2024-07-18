class PostpaidPay
include UssdApis

  def self.checkout(customer,text,ussd_vendor,sdp)
  	next_prompt = lambda { |account,customer,text,kind,option| input_amount(account,customer,text,kind,option)}
  	last_prompt = lambda { |meter,second_param,customer,text,kind,option,ussd_vendor,sdp| last_prompt(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)}

	response = initialize_profile(customer,text,'2\*2','account',next_prompt,last_prompt,ussd_vendor,sdp)

	return response
  end

private

 def self.input_amount(account,customer,text,kind,option)
 	response = "CON Enter amount to pay"
    return response
 end

 def self.last_prompt(meter,amount,customer,text,kind,option,ussd_vendor,sdp)
   online_checkout(meter,amount,customer,ussd_vendor)
 end



end