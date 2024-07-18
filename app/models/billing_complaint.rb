require 'httparty'
class BillingComplaint
  include UssdApis

  #has_many :meterizations
  #has_many :customers, through: :meterizations
  #has_many :mpesas


  def self.register(customer,text,ussd_vendor,sdp)
    implement_back_button(text)

	if text == "6"
	  response = "CON Select option \n1:High Bills\n2:Estimated Bill\n3:Zero Bills\n4:No Bill"
	end

	if text =~ /\A6\*1.*\Z/
	  response = HighBill.register(customer,text,ussd_vendor,'6\*1',sdp)
	end

	if text =~ /\A6\*2.*\Z/
	  response = EstimatedBill.register(customer,text,ussd_vendor,'6\*2',sdp)
	end

	if text =~ /\A6\*3.*\Z/
		response = ZeroBill.register(customer,text,ussd_vendor,'6\*3',sdp)
	end

	if text =~ /\A6\*4.*\Z/
	  response = NoBill.register(customer,text,ussd_vendor,'6\*4',sdp)
	end


	return add_home_buttons(text,response)
  end


end

