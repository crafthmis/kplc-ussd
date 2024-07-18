class TokenQuery < PrepaidMpesa
  self.table_name = "TOKEN_QUERY"
	# a project will always belong to a team.
  #belongs_to :team
  # A project belongs to a user when created.
  #belongs_to :owner, class_name: "User"
  attribute :datetokenreq, :datetime

 include UssdApis

 #def self.test
 # "This is a self class"
 #end

 def self.display_statements(customer,text,ussd_vendor,option,sdp)
  next_prompt = lambda { |meter,customer,text,kind,option| three_previous_statements(meter,customer,text,kind,option)}
  last_prompt = lambda { |meter,second_param,customer,text,kind,option,ussd_vendor,sdp| last_prompt(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)}

  response = initialize_profile(customer,text,'1\*3','meter',next_prompt,last_prompt,ussd_vendor,sdp)

  return response

 end




private






   def self.three_previous_statements(meter,customer,text,kind,option)   #work on error saving and moving to background ,i.e if we have the customers meter we look for token and store them in memory
      #customer.messages.create(:messageable => meter, :service => :prepaid_token)
      begin
       #token = HTTParty.get("http://incms.kplc.local/InCMS-ss-server/services/publicData/?serialNumberMeter=#{meter.number}", :verify => false )
       #token = TokenQuery.where(billrefnumber: meter.number ).last(3).reverse
       #token = TokenQuery.where(billrefnumber: meter.number).last(3).map(&:transid)
       token = TokenQuery.where(billrefnumber: meter.number).last(3)
       #print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{token}"
         ##WHY is asc ordering in descending
         if token.size != 0
          #print ">>>>>>>>#############Token count:#{token.size}"
            response = "CON Choose MPESA reference\n" # to display:#{meter.number}\n"
            token.each_with_index do |key,value|
              response += "#{value + 1}:#{key.transid}\n Date:#{key.datetokenreq.strftime("%d-%m-%Y")}\n"
            end
          else
            response =  "CON We could not find your full statements, kindly call us on 97771"  #Change this to 97771
          end

       rescue StandardError
         ExceptionNotifier.notify_exception(StandardError)
         response = "CON The transaction took too long to complete, kindly try again later."
       end
       return response
    end

  def self.last_prompt(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)
    tokens = TokenQuery.where(billrefnumber: meter.number).last(3)
    chosen_token = tokens[(second_param.to_i-1)]

    #print "##################################2#{tokens.inspect}"
    #print ">>>>>>>>>>>>>>>###################3#{chosen_token.inspect}"

    #print ">>>>>>Meter: #{meter}"
    #print ">>>>>>second_param: #{second_param}"
    #print ">>>>>>customer: #{customer.inspect}"
    #print ">>>>>>text: #{text}"
    #print ">>>>>>kind: #{kind}"
    #print ">>>>>>option: #{option}"
    #print ">>>>>>ussd_vendor: #{ussd_vendor}"
    #response = "CON Full token details enquiry SMS will cost 10 Ksh\n1:Confirm\n2:Cancel"
    response = "CON #{chosen_token.messages}"
  end


end
