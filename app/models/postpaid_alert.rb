class PostpaidAlert 


	def self.register(customer,text)
		if text == "2*3"
		  response = "CON Select alert type\n1. SMS alert\n2. Email alert"
		end


	    if text =~ /\A2\*3\*1.*\Z/
			if text == "2*3*1"
				if customer.sms_notification 
				  response = "CON You are registered to receive SMS bill alerts\n1.Deactive"
				else
				  response = "CON Activate SMS bill alerts\n1.Activate"
				end
			end
			if text == "2*3*1*1"
				if customer.sms_notification == false 
					customer.sms_notification = true 
					response = "CON Your number has been activated to receive bill alerts."
				else
					customer.sms_notification = false 
					response = "CON Your number has been deactivated from receiving bill alerts."
				end
				customer.save
			end
	    end

		if text =~ /\A2\*3\*2.*\Z/
			if text == "2*3*2" ####>>>>>>>>>>>>>>>>     START OF EMAIL BILL ALERTS ################
				if customer.email_notification 
					response = "CON You are registered to receive Email bill alerts\n1.Deactive\n2.Change email"
				else
					response = "CON Activate Email bill alerts\n1.Activate"
				end
			end

			if text =~ /\A2\*3\*2\*1\Z/
				if customer.email_notification == false 
					response = "CON Input your working email address."
				else
					customer.email_notification = false 
					response = "CON Your email has been deactivated from receiving bill alerts."
				end
				customer.save
			end

			if text =~ /\A2\*3\*2\*1\*(.+)\Z/
				 address = $1 
				 customer.email = address
				 customer.email_notification = true   #### activate only after email address has been input
				 response = validate_and_update_email_address(address,customer)
			end

			if text =~ /\A2\*3\*2\*2\Z/
				response = "CON Input your working email address."
			end

			if text =~ /\A2\*3\*2\*2\*(.+)\Z/
				address = $1      
				customer.email = address  ####no need to add email_notification activation as it is already active
				response = validate_and_update_email_address(address,customer)
			end  ####>>>>>>>>>>>>>>>>>>>>> END OF EMAIL BILL ALERTS #################################
				####################### END OF BILL ALERTS ############################
		end

		return response

	end

  private

    def self.validate_and_update_email_address(address,customer)
    if address =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	   customer.save
	   response = "CON Email address #{address} has been activated to receive bill alerts."
	 else
	   response = "CON Email address is of invalid format."
	 end
    return response
  end 


end