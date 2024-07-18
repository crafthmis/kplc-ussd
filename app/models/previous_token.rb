require 'httparty'
class PreviousToken < PrepaidMpesa
  attribute :datetokenreq, :datetime

include UssdApis

 def self.find(customer,text,ussd_vendor,option,sdp)
  next_prompt = lambda { |meter,customer,text,kind,option| three_previous_tokens(meter,customer,text,kind,option)}
  last_prompt = lambda { |meter,second_param,customer,text,kind,option,ussd_vendor,sdp| last_prompt(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)}

  response = initialize_profile(customer,text,'1\*2','meter',next_prompt,last_prompt,ussd_vendor,sdp)

  return response

 end




private

   def self.three_previous_tokens(meter,customer,text,kind,option)   #work on error saving and moving to background ,i.e if we have the customers meter we look for token and store them in memory
      #customer.messages.create(:messageable => meter, :service => :prepaid_token)
      begin
       #token = HTTParty.get("http://incms.kplc.local/InCMS-ss-server/services/publicData/?serialNumberMeter=#{meter.number}", :verify => false )
      #  token = TokenQuery.where(billrefnumber: meter.number).where.not(message: nil).order("datetokenreq ASC").last(3).reverse   ##WHY is asc ordering in descending
        token = TokenQuery.where(billrefnumber: meter.number).last(3)
         if token
            response = "CON Previous token enquiry SMS will cost 10 Ksh\n1:Confirm\n2:Cancel"
          else
            response =  "CON We could not find your previous token,kindly call us on 97771"  #Change this to 97771
          end

       rescue StandardError
         ExceptionNotifier.notify_exception(StandardError)
         response = "CON The transaction took too long to complete, kindly try again later."
       end
       return response
    end

  def self.last_prompt(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)



      if second_param == 1.to_s

        # token = KctToken.where(billrefnumber: meter.number).last(1)
        # message = "Last three tokens for Meter No:#{meter.number}\n"
        # if token.present?
        #   message = key.messages
        #   token_match = message.match(/Token:(\S+)/)
        #   date_match = message.match(/Date:([^\n]+)/)

        #   message += "#{value + 1}:#{token_match} Date:#{date_match}\n"
        # end

        #  token = TokenQuery.where(billrefnumber: meter.number ).where.not(message: nil).order("datetokenreq ASC").last(3).reverse
        token =TokenQuery.where(billrefnumber: meter.number).last(1)
        message = "Last three tokens for Meter No:#{meter.number}\n"
        token.each_with_index do |key,value|
          message = key.messages
          token_match = message.match(/Token:(\S+)/)
          date_match = message.match(/Date:([^\n]+)/)

          message += "#{value + 1}:#{token_match} Date:#{date_match}\n"
        end

       response =  if sdp.empty?
                    "SDP"
                   elsif sdp =~ /\ArequestId:(\d+)\|respTimeStamp:(\d+)\|status:(\d+)\|statusCode:(\d+)\|description:(.+)\Z/
                    #"CON Class: #{sdp.class} SDP:#{sdp}"
                    #"END You will receive an SMS with full token details."
                    $redis.set($1,message,ex: 600)
                         #    billable = customer.billables.new(
                         #                      request_id: $1,
                         #                      request_timestamp: $2,
                         #                      status_code: $3,
                         #                      description: $4,
                         #                      meter: meter,
                         #                      response: message
                         #                  )
                         #   billable.save
                    "END Your request is being processed, kindly wait for the confirmation message."
                   end

      elsif second_param == 2.to_s
        response = "CON Thank you, previous token request cancelled."
      end

      return response

  end




end
