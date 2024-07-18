require 'httparty'

class Account < ApplicationRecord    ###this denotes postpaid
  include Messageable
  include Mpesable
  include UssdApis
  include Complaintable

  has_many :accountments
  has_many :customers, through: :accountments
  has_many :readings


  def self.postpaid(customer,text,ussd_vendor,sdp)
  	 implement_back_button(text)

	  	################## START OF POSTPAID SERVICES #############
	  if text == "2"
	    response = "CON Select option \n1:My bill\n2:Pay bill\n3:Bill alerts\n4:Self reading\n5:Manage Accounts"
	  end

	  if text =~ /\A2\*1.*\Z/
	    response = PostpaidBill.check(customer,text,ussd_vendor,sdp)
	  end

	  if text =~ /\A2\*2.*\Z/
	    response = PostpaidPay.checkout(customer,text,ussd_vendor,sdp)
	  end

	  if text =~ /\A2\*3.*\Z/
	  	response = PostpaidAlert.register(customer,text)
	  end

	  if text =~ /\A2\*4.*\Z/
	  	response = PostpaidRead.register(customer,text,ussd_vendor,sdp)
	  end

	  if text =~ /\A2\*5.*\Z/
	  	#response = PostpaidRead.register(customer,text,ussd_vendor)
	  	response = Accountment.account_management(customer,text,'2\*5')
	  end

	return add_home_buttons(text,response)        ###this is the main response returned to ussd controller

  end




  private





end

















