class PostpaidBill
include UssdApis

  def self.check(customer,text,ussd_vendor,sdp)
  	next_prompt = lambda { |account,customer,text,kind,option| find_balance(account,customer,text,kind,option)}
  	last_prompt = lambda { |meter,second_param,customer,text,kind,option,ussd_vendor,sdp| last_prompt(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)}

	response = initialize_profile(customer,text,'2\*1','account',next_prompt,last_prompt,ussd_vendor,sdp)


	return response
  end

private

 def self.find_balance(account,customer,text,kind,option)
    customer.messages.create(:messageable => account, :service => :postpaid_balance)
   begin
    url = "http://apim.kplc.local:80/accounts/2.0.1/#{account.number}/balance"
    text = HTTParty.get(url, :verify => false )

		 response = if text["data"]
			           "CON Postpaid bill enquiry SMS will cost 10 Ksh\n1:Confirm\n2:Cancel"
			          elsif text["msgDeveloper"]
			     	     "CON #{text["msgDeveloper"]}"
			          else
			     	     "CON We could not find your balance,kindly call us on 97771"  #Change this to 97771
								end

	   rescue StandardError
	   ExceptionNotifier.notify_exception(StandardError)
	     response = "CON The transaction took too long to complete, kindly try again."
	   end

    return response
  end

	def self.last_prompt(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)

		 if second_param == 1.to_s
		 url = "http://apim.kplc.local:80/accounts/2.0.1/#{meter.number}/balance"
     text = HTTParty.get(url, :verify => false )
     #puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>> Postpaid Bill Error: #{text.inspect}\n"
		 message =  "Account: #{text["data"]["accountReference"]}\n Name: #{text["data"]["fullName"]}\n Amount Due: #{text["data"]["formatedBalance"]} Ksh #{text["data"]["balance"] > 0 ? "Overpayment" : ""}\nLatest Bill: #{text["data"]["lastAmount"]} Ksh\n Due Date: #{text["data"]["formatedDueDate"]}"

       response =  if sdp.empty?
                    "SDP"
                   elsif sdp =~ /\ArequestId:(\d+)\|respTimeStamp:(\d+)\|status:(\d+)\|statusCode:(\d+)\|description:(.+)\Z/
                    #"CON Class: #{sdp.class} SDP:#{sdp}"
                    #"END You will receive an SMS with full token details."
                    $redis.set($1,message,ex: 600)
                             #billable =   customer.billables.new(
                             #                  request_id: $1,
                             #                  request_timestamp: $2,
                             #                  status_code: $3,
                             #                  description: $4,
                             #                  account: meter,
                             #                  response: message
                             #              )
                             #billable.save
                    "END Your request is being processed, kindly wait for the confirmation message."
                   end

      elsif second_param == 2.to_s
        response = "CON Thank you, postpaid bill request cancelled."
      end

			return response

  end
end