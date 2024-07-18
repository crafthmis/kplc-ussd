class Accountment < ApplicationRecord

 belongs_to :customer
 belongs_to :account
 include UssdApis

 def self.account_management(customer,text,option)
   #implement_back_button(text)
   #option = '(2\*5|6\*2)'


    if text =~ /\A#{option}\Z/
     response = "CON Select \n1:Add account to profile\n2:Remove account from profile"
    end

    if text =~ /\A#{option}\*1\Z/
      response = "CON Input account number"
    end

    if text =~ /\A#{option}\*1\*(\d+)\Z/
      response = add_account($1,customer)
    end

    if text =~ /\A#{option}\*2\Z/
        if customer.accounts.exists? 
          response = "CON Select account\n"
            customer.accounts.order(:number).each_with_index do |key,value| 
              response += "#{value+1}:#{key.number}\n"
            end
        else
          response = "CON No postpaid account linked to profile"
        end
    end

    if text =~ /\A#{option}\*2\*(\d+)\Z/
      account = customer.accounts.order(:number).offset($1.to_i-1).first
       if account
          response = remove_account(account,customer)
        else
          response = "CON Incorrect option selected"
        end
    end

    return response #add_home_buttons(text,response)
 end






private 

 def self.remove_account(meter,customer)
    Accountment.where(customer_id: customer.id).where(account_id: meter.id).delete_all
    response = "CON Account No:#{meter.number} has been removed from this profile."
    return response 
 end

  def self.add_account(number,customer)
    max_retries = 1
    times_retried = 0
     #url = "http://apim.kplc.local:80/accounts/2.0.1/#{number}/balance"
     #url = "http://apim.kplc.local/accounts/2.0.1/#{number}/balance"

    #text = HTTParty.get(url, :verify => false)

    begin
      url = "http://apim.kplc.local/accounts/2.0.1/#{number}/balance"
      text = HTTParty.get(url, :verify => false, open_timeout: 0.1 ) ###If previous balance exists then create ,TODO: What if the meter is new and there is no balance
      if text["data"] 
        account = customer.accounts.find_or_create_by(number: number) ##TODO: After finding previous token ,lets store it on memory so as not to query incase they wanted previous bill 
        response = "CON Postpaid account was successfully added."
      elsif text["msgDeveloper"]
        response = "CON The account number could not be found, kindly call us on 97771."
      end
    rescue StandardError
      
      if times_retried < max_retries
        times_retried += 1
        #puts "Failed to <do the thing>, retry #{times_retried}/#{max_retries}"
        retry
      else
        #ExceptionNotifier.notify_exception(StandardError)
        #puts "Exiting script. <explanation of why this is unlikely to recover>"
        response = "CON The request took too long, kindly try again later."
        #exit(1)
      end
            #nil
    end


    return response
  end



end

