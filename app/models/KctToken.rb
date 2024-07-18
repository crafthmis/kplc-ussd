class KctToken < PrepaidMpesa
  self.table_name = "IPMP_MPESA.KCT_TOKEN"
  # belongs_to :TokenQuery, class_name: "TokenQuery", foreign_key: "seqnum"
  attribute :datetokenreq, :datetime

  include UssdApis

  # Method to initiate the USSD flow for displaying KCT tokens
  def self.display_kct(customer, text, ussd_vendor, option, sdp)
    next_prompt = lambda { |meter, customer, text, kind, option| key_change(meter, customer, text, kind, option) }
    last_prompt = lambda { |meter, second_param, customer, text, kind, option, ussd_vendor, sdp| last_prompt(meter, second_param, customer, text, kind, option, ussd_vendor, sdp) }

    initialize_profile(customer, text, '1\*4', 'meter', next_prompt, last_prompt, ussd_vendor, sdp)
  end

  private

  # Method to handle the first stage of token retrieval and display
  def self.key_change(meter,customer,text,kind,option)
    begin
     token = KctToken.where(billrefnumber: meter.number).last(1)
     if token.present?
      response = "CON Meter: #{meter.number}:\n"
      first = token.first
      kct = first.kct
      kct_parts = kct.split('|')
      reset_code = kct_parts[0]
      update_code = kct_parts[1]

      response += "Reset: #{reset_code} \nUpdate: #{update_code}"

    else
      response = "CON We could not find your KCT token, kindly call us on 97771"
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
