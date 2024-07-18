class UssdController < ApplicationController
    def index
      msisdn = params[:MSISDN]
      ussd_string = params[:ussd_string]
      session_id = params[:session_id]
      service_code = params[:service_code]
      option = ussd_string.split('*').last
      sdp = params[:sdp_string]
  
      customer = Customer.find_by(phone_number: msisdn)
      ussd_vendor = 'your_ussd_vendor' # Replace with the actual vendor
  
      response = KctToken.display_statements2(customer, ussd_string, ussd_vendor, option, sdp)
      
      render plain: response
    end
  end
  