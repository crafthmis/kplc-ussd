class PostpaidRead
include UssdApis


 def self.register(customer,text,ussd_vendor,sdp)
  	next_prompt = lambda { |account,customer,text,kind,option| choose_account(account,customer,text,kind,option)}
  	last_prompt = lambda { |account,chosen_meter,customer,text,kind,option,ussd_vendor,sdp| choose_meter(account,chosen_meter,customer,text,kind,option,ussd_vendor,sdp)}

	initialize_response = initialize_profile(customer,text,'2\*4','account',next_prompt,last_prompt,ussd_vendor,sdp)
	#puts ">>>>>>>>>>>>>>>>>>>>>>>>>.#{initialize_response}"
    #get_response = ""  ##very last method for capturing reading ##Copy implementation of this from the main lambda
	#puts ">>>>>>>>>>>>>>>>>>>>#{get_response}"

	if initialize_response
   response = initialize_response
   #puts ">>>>>>>>>>>>>>>>>>>>>#{response}"
	else
   response = passing_the_input_reading(customer,text)
   #puts ">>>>>>>>>>>>>>>>>>>>>>#{response}"
	end
#25232497 test before billing period
#normal test  2223995
   return response
 end



 private
	  def self.passing_the_input_reading(customer,text)
		#response = ""
		#puts "customer and test"
		implement_back_button(text)
    #print "nothing here see First"  ##two scenarios ,first timers or repeat

			## if cus.ac.siz == 1 &&
			##
      #print "nothing here see second"
      #2*4*2*73875835*1*6578
     if text =~ /\A2\*4\*(\d+)\*(1|2)\*(\d+)\Z/
		  #if customer.accounts.size == 1
			#value 1 could be adding account ,value 1 could be offset or value 1 could be new account reading persion
			#2*4*33007416 new customer
			#2*4*25483652*1*7552 new customer
			#2*4*26064865*1*1966
			#2*4*1*1*1*2093
			#2*4*3*3464434*1*2098
			#2*4*1*1*4924
			#2*4*42853989
			#2*4*1*1*6369
			#2*4*6*364345664*2*4565
		  	 #meter_position = $1
			 # meter_position = $2 reading , or position
			  #meter_type = $2
			  #meter_reading = $3
               #option 1 is meter ,options 2 is meter type ,option 3 is reading
				  opt_1 ,opt_2,opt_3 = $1, $2 ,$3                ##The regex makes sure 1*1*2*87689876734*20 ,this is rejected,does not take greadily like .* ,ends at the *
          account = customer.accounts.find_by_number(opt_1)
          account_selected = customer.get_selected(opt_1.to_i,"account")
				  if account
					  response = capture_reading(account,opt_2,opt_3)
          elsif account_selected
					  response = capture_reading(account_selected,opt_2,opt_3)
          end


			 #print "nothing here see third"

			   #puts ">>>>#{value}>>>>>>>#{meter_position}>>>>>>>>>>>>>>>>>>>>#{reading}"
			  #account  = customer.accounts.order(:number).offset(value.to_i-1).first
			  #response = capture_reading(account,meter_position,reading)
			#end
			#response
		#else
			#print "nothing here see fourth"
			#if text =~ /\A2\*4\*(\d+)\*(\d+)\*(\d+)\Z/
			 #print "nothing here see fifth"
			 # value = $1
			 # meter_position = $2
			 # reading = $3
			  #puts ">>>>#{value}>>>>>>>#{meter_position}>>>>>>>>>>>>>>>>>>>>#{reading}"
			   #print "nothing here sixth"
			 # account  = customer.accounts.order(:number).offset(value.to_i-1).first

			 # response = capture_reading(account,meter_position,reading)
			#end
			#response
      #print "nothing here see seventh"
    elsif text =~ /\A2\*4\*(\d+)\*(\d+)\*(1|2)\*(\d+)\Z/
      opt_1 ,opt_2,opt_3,opt_4 = $1, $2 ,$3 ,$4
      account = customer.accounts.find_by_number(opt_2)
      if account
       response = capture_reading(account,opt_3,opt_4)
      end
		end
		#print "nothing here see eighth"
		return response
    end

	 def self.choose_account(account,customer,text,kind,option) ##kind "account" ,option "2\*4"
		account_details = return_account_details(account.number)
	    if account_details["data"] && account_details["data"].class.to_s == "Array"
	    	id_account = account_details["data"].first["idAccount"]
	    	id_sector_supply = account_details["data"].first["idSectorSupply"]
			phone = {
			       "phone": "+254#{customer.number.split("").last(9).join}"
			}
			register_number = HTTParty.put("#{ENV['apim_url']}/sectorSupplies/#{ENV['apim_version']}/#{id_sector_supply}/selfReader/", :body => phone.to_json, :headers => headers ,verify: false)
			billing_period = HTTParty.get("#{ENV['apim_url']}/accounts/#{ENV['apim_version']}/#{id_account}/selfReadsAvailable/", :headers => headers  ,verify: false)
			billing_cycle = billing_period["data"].first["hasSelfRead"]

           #puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{billing_cycle}"
           #puts billing_cycle == true
           #puts billing_cycle == false
           #puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{billing_cycle}"
			response =	if billing_cycle
						  meters_under_account ||= HTTParty.get("#{ENV['apim_url']}/accounts/#{ENV['apim_version']}/#{id_account}/selfReads/", :headers => headers  ,verify: false)
						  text = "CON Select Meter\n"
						  meters_under_account["data"].each_with_index do |key,value|
							text += "#{value + 1}: #{key['consumTypeDesc']} Meter No.#{key['numMeter']}\n"
						  end
						  text
						else
						  submission_period = HTTParty.get("#{ENV['apim_url']}/selfReadsPeriod/#{ENV['apim_version']}/#{id_sector_supply}", :headers => headers  ,verify: false)
						  next_read_date = submission_period['data'][0]["plannedReadDate"]
						  epoch_time = next_read_date/1000
						  read_date =  DateTime.strptime(epoch_time.to_s,'%s')
						  display_date = read_date + 1
						  display_value = display_date.strftime("%d-%b-%Y")
						   "CON Reading period is scheduled on #{display_value}"
						end
		elsif account_details["data"] && account_details["data"].class.to_s == "String"
			response = "CON This service is not available for the requested account."
			#puts ">>>>>>>>>>>>>>#{account_details["data"]}"
		else
		  response = "CON This service is currently unavailable,try again later."
		end

		return response
	 end


	 def self.choose_meter(account,chosen_meter,customer,text,kind,option,ussd_vendor,sdp)
	   #account_details =  return_account_details(account.number)
	   #id_account = account_details["data"].first["idAccount"]
	   #meters_under_account = HTTParty.get("#{ENV['apim_url']}/accounts/#{ENV['apim_version']}/#{id_account}/selfReads/", :headers => headers  ,verify: false)
	   response = "CON Enter your meter reading"
	 end

	 def self.capture_reading(account,meter_position,reading)
		account_details = return_account_details(account.number)
		#puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{account_details.inspect}"
		id_account = account_details["data"].first["idAccount"]

		meters_under_account = HTTParty.get("#{ENV['apim_url']}/accounts/#{ENV['apim_version']}/#{id_account}/selfReads/", :headers => headers  ,verify: false)


		idService = meters_under_account["data"][meter_position.to_i - 1]['idService']
	  consumType = meters_under_account["data"][meter_position.to_i - 1]['consumType']
	  numMeter = meters_under_account["data"][meter_position.to_i - 1]['numMeter']
	  input_reading = reading

    #puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{consumType}>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{numMeter}>>>>>>>>>>>>>>>>>>>#{input_reading}"
	    reading = {
	        "idService": idService.to_i,
	        "readings": [
	            {
	                "serialNum": numMeter,
	                "consumType": consumType,
	                "readingValue": input_reading
	            }
	        ]
	    }

	    request = HTTParty.post("#{ENV['apim_url']}/accounts/#{ENV['apim_version']}/#{id_account}/selfReads", body: reading.to_json ,:headers => headers,verify: false)
		response = 	if request.success?
					  "CON Reading submitted successfully."
					else
					  "CON Submission failed, contact the Commercial Office closest to your home for more information."
					end
	    return response
	 end


	def self.return_account_details(number)
	  meter_number = {
		                 "accountReference" => number
		    	} #

	  account_details = HTTParty.get("#{ENV['apim_url']}/sectorSupplies/#{ENV['apim_version']}/",:query => meter_number,:headers => headers,verify: false)
	  #puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{account_details.inspect}"
	  return account_details
	end

    def self.headers
    	headers = {
            "Content-Type" => "application/json",
            "X-Requested-With" => "XMLHttpRequest",
            "Authorization" => "Bearer #{ENV['apim_token']}"

          }
    end



 end








