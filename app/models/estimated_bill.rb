class EstimatedBill
include UssdApis

 def self.register(customer,text,ussd_vendor,option,sdp)
 	next_prompt = lambda { |account,customer,text,kind,option| input_amount(account,customer,text,kind,option)}
 	last_prompt = lambda { |meter,amount,customer,text,kind,option,ussd_vendor,sdp| last_prompt(meter,amount,customer,text,kind,option,ussd_vendor,sdp)}

	response = initialize_profile(customer,text,'6\*2','account',next_prompt,last_prompt,ussd_vendor,sdp)



   return response
end

private

###Notes####
### Move headers and id_account methods to ussd apis concern
### Create one method that accepts the params for creating this rccs to be injected to last prompt with a complaint type as a different param
### Capture id account on the input amount method and submit it via redis, using account number as key and id_account as value
  def self.input_amount(account,customer,text,kind,option)
    #$redis.set($1,message,ex: 600)
	  response = "CON Input your current reading"
	end

	def self.last_prompt(account,current_reading,customer,text,kind,option,ussd_vendor,sdp)
      billing_rri(account,current_reading,customer,"0009KPLTYP")
  end



end