class Meterization < ApplicationRecord
 belongs_to :customer
 belongs_to :meter
 include UssdApis


 def self.meter_management(customer,text,option)
    #implement_back_button(text)
    #option = '(1\*3|6\*1)'
    
    # if text == "6" #test this cross functionality ,ability to move across menus
    #   response = "CON Select account type\n1.Prepaid\n2.Postpaid"
    # end

    if text =~ /\A#{option}\Z/
     response = "CON Select \n1:Add meter to profile\n2:Remove meter from profile"
    end

    if text =~ /\A#{option}\*1\Z/
       response = "CON Input meter number"
    end

    if text =~ /\A#{option}\*1\*(\d+)\Z/
       response = add_meter($1,customer)
    end

    if text =~ /\A#{option}\*2\Z/
        if customer.meters.exists? 
          response = "CON Select meter\n"
              customer.meters.order(:number).each_with_index do |key,value| 
                response += "#{value+1}:#{key.number}\n"
              end
        else
          response = "CON No prepaid account linked to profile"
        end
    end

    if text =~ /\A#{option}\*2\*(\d)\Z/
       meter = customer.meters.order(:number).offset($1.to_i - 1).first
       if meter
          response = remove_meter(meter,customer)
        else
          response = "CON Incorrect option selected"
        end
    end

    return response #add_home_buttons(text,response)
 end

 private 

  def self.remove_meter(meter,customer)
    Meterization.where(customer_id: customer.id).where(meter_id: meter.id).delete_all
    response = "CON Meter No:#{meter.number} has been removed from this profile."
    return response 
 end

  def self.add_meter(number,customer)
    if number =~ /\A\d{11}\Z/
      meter = customer.meters.find_or_create_by(number: number)  ##TODO: After finding previous token ,lets store it on memory so as not to query incase they wanted previous token
      response = "CON Prepaid meter was successfully added."
    else  ###Rejects prepaid meters with less than 11 digits or more digits or alphanumerical
      response = "CON The meter number entered is incorrect."
    end

    return response
  end

end
