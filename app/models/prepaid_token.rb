class PrepaidToken
include UssdApis

 def self.buy(customer,text,ussd_vendor,option,sdp)
 	next_prompt = lambda { |account,customer,text,kind,option| input_amount(account,customer,text,kind,option)}
 	last_prompt = lambda { |meter,amount,customer,text,kind,option,ussd_vendor,sdp| last_prompt(meter,amount,customer,text,kind,option,ussd_vendor,sdp)}

	response = initialize_profile(customer,text,'1\*1','meter',next_prompt,last_prompt,ussd_vendor,sdp)



   return response
end

private
	def self.input_amount(account,customer,text,kind,option)
	  response = "CON Enter Amount In Ksh"
	end

	def self.last_prompt(meter,amount,customer,text,kind,option,ussd_vendor,sdp)
	  online_checkout(meter,amount,customer,ussd_vendor)
	end

end
