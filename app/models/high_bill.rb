class HighBill
include UssdApis

 def self.register(customer,text,ussd_vendor,option,sdp)
 	next_prompt = lambda { |account,customer,text,kind,option| input_amount(account,customer,text,kind,option)}
 	last_prompt = lambda { |meter,amount,customer,text,kind,option,ussd_vendor,sdp| last_prompt(meter,amount,customer,text,kind,option,ussd_vendor,sdp)}

	response = initialize_profile(customer,text,'6\*1','account',next_prompt,last_prompt,ussd_vendor,sdp)



   return response
end

private
	def self.input_amount(account,customer,text,kind,option)
	  response = "CON Input your current reading"
	end

	def self.last_prompt(account,current_reading,customer,text,kind,option,ussd_vendor,sdp)
    billing_rri(account,current_reading,customer,"0010KPLTYP")
	end



end
