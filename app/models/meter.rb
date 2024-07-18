require 'httparty'
class Meter < ApplicationRecord     ###this denotes prepaid
  include Messageable
  include Mpesable
  include UssdApis
  include Complaintable

  has_many :meterizations
  has_many :customers, through: :meterizations
  has_many :mpesas


  def self.prepaid(customer,text,ussd_vendor,sdp)
    implement_back_button(text)

	if text == "1"
	#   response = "CON Select option \n1:Buy Token\n2:Latest Token\n3:Retrieve Token\n4:File Complaint"
	  response = "CON Select option \n1:Buy Token\n2:Latest Token\n3:Token Details\n4:Update Meter Yako\n5:Manage Meters" #\n4:File Complaint"
	end

	if text =~ /\A1\*1/
		logger.info("text: #{text}")
	  response = PrepaidToken.buy(customer,text,ussd_vendor,'1\*1',sdp)
	end

	if text =~ /\A1\*2/
	  response = PreviousToken.find(customer,text,ussd_vendor,'1\*2',sdp)
	end

	if text =~ /\A1\*3.*\Z/
		#response = PreviousToken.find(customer,text,ussd_vendor)
		response = TokenQuery.display_statements(customer,text,ussd_vendor,'1\*3',sdp)
	  #response = "CON Input MPESA reference number."
	end

	if text =~ /\A1\*4/
		# Rails.logger.info("text: #{text}")
		#response = PreviousToken.find(customer,text,ussd_vendor)
		response = KctToken.display_kct(customer,text,ussd_vendor,'1\*4',sdp)
		# response = TokenQuery.display_kct(customer,text,ussd_vendor,'1\*4',sdp)
	  #response = "CON Input MPESA reference number."
	end

	if text =~ /\A1\*5.*\Z/
		#response = PreviousToken.find(customer,text,ussd_vendor)
		#response = "CON Input MPESA reference number."
		response = Meterization.meter_management(customer,text,'1\*5')
	end

	#if text =~ /\A1\*4.*\Z/
	  #response = PreviousToken.find(customer,text,ussd_vendor)
	#end


	return add_home_buttons(text,response)
  end

end
