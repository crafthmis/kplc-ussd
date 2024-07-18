# require 'httparty'

# require "faraday"
# require 'typhoeus'
# require 'benchmark'

require 'httparty'

class Wunderground
  include HTTParty
  format :json

  base_uri ENV['apim_url']

  attr_accessor :temp, :location, :icon, :desc, :url, :feel_like

  def initialize(response)
    @temp = response['current_observation']['temp_f']
    @location = response['current_observation']['display_location']['full']
    @icon = response['current_observation']['icon_url']
    @desc = response['current_observation']['weather']
    @url = response['current_observation']['forecast_url']
    @feel_like = response['current_observation']['feelslike_f']
  end

  def self.get_weather(state, city)
    response = get("/api/#{ENV["wunderground_key"]}/conditions/q/#{state}/#{city}.json")
    if response.success?
      new(response)
    else
      raise response.response
    end
  end

end

puts Wunderground.get_weather("NewYork", "NewYork")
# data = <<-EOF
# <ns0:ESBMsg xmlns:acs="http://xmlns.equitybank.co.ke/ESB/EO/Resilience/Access/V1" xmlns:ns0="http://xmlns.equitybank.co.ke/ESB/EO/Transactions/Payment/V1">
# <com:MsgID xmlns:com="http://xmlns.equitybank.co.ke/ESB/EO/Common/V1">2b824e4d-de7a-440f-bd5e-0aed6bf6fb11</com:MsgID>

# 	<ns0:RqData actionCode="CreateBillPayment">
# 	<ns0:Payment>
# 	<com:PaymentIdentifier xmlns:com="http://xmlns.equitybank.co.ke/ESB/EO/Common/V1">
# 	<com:PaymentID>17967489</com:PaymentID>
# 	</com:PaymentIdentifier>
# 		<ns0:PaymentType>EazzyPayOnline</ns0:PaymentType>
# 		<com:Phone xmlns:com="http://xmlns.equitybank.co.ke/ESB/EO/Common/V1">
# 		<com:CompleteNumber>254765885551</com:CompleteNumber>
# 	</com:Phone>
# 	<com:Amount xmlns:com="http://xmlns.equitybank.co.ke/ESB/EO/Common/V1">140.00</com:Amount>
# 	<com:Remarks xmlns:com="http://xmlns.equitybank.co.ke/ESB/EO/Common/V1">Buy Insurance</com:Remarks><com:UserID
# 	xmlns:com="http://xmlns.equitybank.co.ke/ESB/EO/Common/V1">2729595587</com:UserID></ns0:Payment>

# 	</ns0:RqData>
# </ns0:ESBMsg>
# EOF


# data_second = <<-EOF
# <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
#   <soap:Body>
#     <GetWeather xmlns="http://www.webserviceX.NET">
#       <CityName>Madras</CityName>
#       <CountryName>India</CountryName>
#     </GetWeather>
#   </soap:Body>
# </soap:Envelope>
# EOF

# headers = {
#   'Content-Type' => 'text/xml; charset=utf-8',
#   'SOAPAction' => "http://www.webserviceX.NET/GetWeather"
# }
# 	 url = "http://apimdev.kplc.local"
# 	 #url = "http://172.16.10.108"
# 	 #url = "172.16.11.114"
# 	 version = "3.0.1"
# 	 account =   973424 #47042221 1848662
# 	 id_account = "1645755" #574719
# 	 token = "7e8868a09a13b2c841be194022c27b64"
# 	 id_sector_supply =  "1320425" #"354477"


# 	headers = {
# 		"Content-Type" =>  "application/json",
# 		"X-Requested-With" =>  "XMLHttpRequest",
# 		"Authorization" => "Bearer #{token}"
# 	}

# 	meter_number = {
# 	        "accountReference" => account 
# 	} 

# 	headers = {
# 	    "Content-Type" => "application/json",
# 	    "X-Requested-With" => "XMLHttpRequest",
# 	    "Authorization" => "Bearer #{token}"
	    
# 	  }

# puts ">>>>>>>>>#{url}"


#   Benchmark.bm do |benchmark|

#   	benchmark.report("Httpary gem") do
#   	      puts "1......................."
# 		  account_details ||= HTTParty.get("#{url}/sectorSupplies/#{version}/",:query => meter_number,:headers => headers,verify: false)

# 		 if account_details["data"] && account_details["data"].class.to_s == "Array"
# 		  id_account = account_details["data"].first["idAccount"]
# 	      id_sector_supply = account_details["data"].first["idSectorSupply"]
# 	      	phone = {
# 			       "phone": "+254712829808"
# 			}

# 	      puts "2..............REgistration"
# 	      	register_number = HTTParty.put("#{url}/sectorSupplies/#{version}/#{id_sector_supply}/selfReader/", :body => phone.to_json, :headers => headers ,verify: false)
#           puts "3..............Check if billing cycle"
# 			billing_period = HTTParty.get("#{url}/accounts/#{version}/#{id_account}/selfReadsAvailable/", :headers => headers  ,verify: false)
# 			billing_cycle = billing_period["data"].first["hasSelfRead"]

# 			if billing_cycle
# 			    meters_under_account = HTTParty.get("#{url}/accounts/#{version}/#{id_account}/selfReads/", :headers => headers  ,verify: false)
# 				text = "CON Select Meter\n"
# 				meters_under_account["data"].each_with_index do |key,value| 
# 				  text += "#{value + 1}: #{key['consumTypeDesc']} Meter No.#{key['numMeter']}\n"
# 				end
# 				response = text 
# 			else
# 				submission_period = HTTParty.get("#{url}/selfReadsPeriod/#{version}/#{id_sector_supply}", :headers => headers  ,verify: false)
# 				next_read_date = submission_period['data'][0]["plannedReadDate"]
# 				epoch_time = next_read_date/1000 
# 				read_date =  DateTime.strptime(epoch_time.to_s,'%s')
# 				display_date = read_date + 1 
# 				display_value = display_date.strftime("%d-%b-%Y")
# 				response = "CON Reading period is scheduled on #{display_value}"
# 			end
# 		elsif account_details["data"] && account_details["data"].class.to_s == "String"
# 			response = "CON This service is not available for the requested account."
# 		else
# 			 response = "CON This service is currently unavailable,try again later."
# 	    end
      

# 			reading = 	{

# 							    "idService": 1320425,

# 							    "readings": [

# 							        {

# 							            "serialNum": "061919903",

# 							            "consumType": "TPCONS0001",

# 							            "readingValue": 123

# 							        }

# 							    ]

# 							}


# 	    request = HTTParty.post("#{url}/accounts/#{version}/#{id_account}/selfReads", body: reading.to_json ,:headers => headers,verify: false)
# 	    if request.success?
# 	     puts response = "CON Reading submitted successfully."

# 	    else
# 	      puts response = "CON Submission failed, contact the Commercial Office closest to your home for more information."
# 	    end


#         number = "1848662"
# 	    url = "http://apim.kplc.local/accounts/2.0.1/#{number}/balance"
#         #url = "http://172.16.11.140:80/accounts/2.0.1/#{number}/balance"
#         text = HTTParty.get(url, :verify => false ) ###If previous balance exists then create ,TODO: What if the meter is new and there is no balance


#          puts text















#     end
#    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>"
#     benchmark.report("Typheus gem") do
#     	     puts "1......................."
# 		    account_details_t =	Typhoeus.get("#{url}/sectorSupplies/#{version}/",
# 		        headers: headers,
# 		        params: meter_number
# 		    )
# 	        puts account_details_t.body[0]
#    end




#   end
    #http://apim.kplc.local/sectorSupplies/2.0.1/?accountReference=47042221

    #billing_period = HTTParty.get("#{url}/accounts/#{version}/#{id_account}/selfReadsAvailable/", :headers => headers  ,verify: false)


    #puts billing_period

  # #1. Get account reference and extract id account and id sector supply 
  #  meter_number = {
		#                  "accountReference" =>  account    #"18486672" #{}"04213142682"
		#     	} #
  #  account_details ||= HTTParty.get("#{url}/sectorSupplies/#{version}/",:query => meter_number,:headers => headers,verify: false)

  #  puts account_details["data"] #["data"].class.to_s == "String"

  #  if account_details["data"] && account_details["data"].class.to_s == "Array"
  #  	unless billing_period["data"].first["hasSelfRead"]
	 #   	account_details = HTTParty.get("#{url}/selfReadsPeriod/#{version}/#{id_sector_supply}",:headers => headers,verify: false)
		# next_read_date = account_details['data'][0]["plannedReadDate"]
		# read_date = Time.at(next_read_date).to_datetime
	 #    epoch_time = next_read_date/1000 
		# read_date =  DateTime.strptime(epoch_time.to_s,'%s')
		# read_date += 1 
		# puts read_date.strftime("%d-%b-%Y")
  #  	end
  #  elsif account_details["data"] && account_details["data"].class.to_s == "String"
  #  	puts  "CON Service not available for the account number."
  #  else
  #  	puts "CON This service is currently unavailable,try again later."
  #  end

  #  puts "check account exists"
  #  url = "http://apim.kplc.local:80/accounts/2.0.1/#{account}/balance"
  #  endpoint = "http://172.16.11.140:80/accounts/2.0.1/#{account}/balance"
  #  text = HTTParty.get(endpoint)
  #  puts text.inspect
   		
   		


   #puts id_account_dy = account_details["data"].first["idAccount"]
   #puts id_sector_supply_dy = account_details["data"].first["idSectorSupply"]


   #register_number = HTTParty.put("#{url}/sectorSupplies/#{version}/#{id_sector_supply}/selfReader/", :body => phone.to_json, :headers => headers ,verify: false)


 #   billing_period = HTTParty.get("#{url}/accounts/#{version}/#{id_account}/selfReadsAvailable/", :headers => headers  ,verify: false)

 #   #puts billing_period


	# account_details = HTTParty.get("#{url}/selfReadsPeriod/#{version}/#{id_sector_supply}",:headers => headers,verify: false)
	# next_read_date = account_details['data'][0]["plannedReadDate"]
	# read_date = Time.at(next_read_date).to_datetime
 #    epoch_time = next_read_date/1000 


	# puts DateTime.strptime(epoch_time.to_s,'%s').strftime("%d-%b-%Y")

	#puts next_read_date/(31556926 * 1000) + 1970





	#.strptime(string, "%Y-%m-%dT%H:%M:%S%z").in_time_zone


# headers = {
# 	"Content-Type": "application/json",
# 	"X-Authorization": "Basic #{auth}"
# }


# request_body = {
#                           "username": "ussd",
#                           "password": "kplctest123",
#                           "scope": "apim:subscribe"
#                         }



# account_details = HTTParty.get("#{url}/token",body: request_body, :headers => headers,verify: false)



		 


 #     puts response
 #    require 'rley' # Load Rley library
 #      require 'strscan'

 #    # Let's create a facade object called 'engine'
 #    # It provides a unified, higher-level interface
 #    engine = Rley::Engine.new

 #    engine.build_grammar do
 #      # Terminal symbols (= word categories in lexicon)
 #      add_terminals('Noun', 'Proper-Noun', 'Verbjk')
 #      add_terminals('Determiner', 'Preposition')

 #      # Here we define the productions (= grammar rules)
 #      rule 'S' => 'NP VP'
 #      rule 'NP' => 'Proper-Noun'
 #      rule 'NP' => 'Determiner Noun'
 #      rule 'NP' => 'Determiner Noun PP'
 #      rule 'VP' => 'Verb NP'
 #      rule 'VP' => 'Verb NP PP'
 #      rule 'PP' => 'Preposition NP'
 #    end
 #        Lexicon = {
 #      'man' => 'Noun',
 #      'dog' => 'Noun',
 #      'cat' => 'Noun',
 #      'telescope' => 'Noun',
 #      'park' => 'Noun',  
 #      'saw' => 'Verb',
 #      'ate' => 'Verb',
 #      'walked' => 'Verb',
 #      'John' => 'Proper-Noun',
 #      'Mary' => 'Proper-Noun',
 #      'Bob' => 'Proper-Noun',
 #      'a' => 'Determiner',
 #      'an' => 'Determiner',
 #      'the' => 'Determiner',
 #      'my' => 'Determiner',
 #      'in' => 'Preposition',
 #      'on' => 'Preposition',
 #      'by' => 'Preposition',
 #      'with' => 'Preposition'
 #    }.freeze

 #        # A tokenizer reads the input string and converts it into a sequence of tokens.
 #    # Remark: Rley doesn't provide tokenizer functionality.
 #    # Highly simplified tokenizer implementation
 #    def tokenizer(aTextToParse)
 #      scanner = StringScanner.new(aTextToParse)
 #      tokens = []

 #      loop do
 #        scanner.skip(/\s+/)
 #        curr_pos = scanner.pos
 #        word = scanner.scan(/\S+/)
 #        break unless word

 #        term_name = Lexicon[word]
 #        raise StandardError, "Word '#{word}' not found in lexicon" if term_name.nil?
 #        pos = Rley::Lexical::Position.new(1, curr_pos + 1)
 #        tokens << Rley::Lexical::Token.new(word, term_name, pos)
 #      end

 #      return tokens
 #    end



 #   input_to_parse = 'John saw Mary with a telescope'
 #    # Convert input text into a sequence of token objects...
 #    tokens = tokenizer(input_to_parse)
 #    result = engine.parse(tokens)

 # puts "Parsing successful? #{result.success?}" # => Parsing successful? true
