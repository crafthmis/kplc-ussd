module UssdApis
  extend ActiveSupport::Concern

 class_methods do
     def initialize_profile(customer,text,option,kind,next_prompt,last_prompt,ussd_vendor,sdp)
         accounts_count = customer.send(kind.pluralize).size

         if text =~ /\A#{option}\Z/
              if accounts_count == 0
                 response = "CON Input your #{kind} number"
              else
                response = "CON Select #{kind}\n"
                response += customer.send("listing_#{kind.pluralize}") ##the last option here should be stored in redis
               end
         elsif text =~ /\A#{option}\*([^*]+)\Z/ ##2*1*34543545*2 #somene with more accounts pastes nontheless

                 opt_1 = $1
                 if accounts_count == 0
                     response = verify_and_create_meter(opt_1,customer,kind,next_prompt,text,option)
                 elsif opt_1.to_i <= accounts_count
                    account = customer.get_selected(opt_1.to_i,kind)
                    response = next_prompt.call(account,customer,text,kind,option)
                 elsif opt_1.to_i == accounts_count + 1
                    response = "CON Input your #{kind} number"
                 end
                   #40268611
                   # response = "CON Incorrect option selected"
          elsif text =~ /\A#{option}\*([^*]+)\*([^*]+)\Z/  ##2*1*4*345454542 #2*1*34543545*2 -> has account with other numbers ,but pastes number , gets added , then gets the abitratry offer
            #2*4  -> 345454*1(FIRST TIMER IF AD ! SLECT)  4*1 2*4 *3*989895() ->lAST PROMPT*13
            ##First time customer 2*4*123485994*100 first value is added_account , second value is arbitrary
            ##Secod value e.g 2*4*3(addmore)*1233434 * permission marketting * 100
            ##Second 2*4*1*100  first value displacement second value arbitrary first value old account displacement ,second value arbirary
            ##third 2*4*2*3808234 *100 first value == accounts +1 , second value == account number third value arbitrary ,the last option for this value will be finished in the below options
             opt_1, opt_2 = $1, $2
            #accounts_count = customer.send(kind.pluralize).size
            #  new_account = customer.send(kind.pluralize).find_by_number(opt_1)
            #selected_account = customer.send(kind.pluralize).order(:number).offset(opt_1-1).first ##very presumptive , somene can have 5 accounts and buys token for 5 bob investigate
            added_account = customer.send(kind.pluralize).find_by_number(opt_1)

            #  puts "new_account: #{new_account}"
            #  puts "selected_account: #{selected_account}"
            #  puts "added_account: #{added_account}"
            #  puts "accounts_count: #{accounts_count}"
          if accounts_count == 1 && added_account ##Last prompt for first timers
            #if added_account
              response = last_prompt.call(added_account,opt_2,customer,text,kind,option,ussd_vendor,sdp)
            #else

            #end
            #account = self.return_account_details(account)
            #account = customer.get_accounts(kind).first

          elsif opt_1.to_i <= accounts_count ##old users selecting there old account option
            account = customer.get_selected(opt_1.to_i,kind)
            #account = customer.accounts.order(:number).offset(opt_1-1).first   ###When the last value is any character ,from next_prompt ,it goes here
            response = last_prompt.call(account,opt_2,customer,text,kind,option,ussd_vendor,sdp)
          elsif opt_1.to_i == accounts_count + 1 ##repeat user adding accounts
            response = verify_and_create_meter(opt_2,customer,kind,next_prompt,text,option)
          end


              #  #  text =~ /\A#{option}\*(\d+)\*([^*]+)\Z/    ##The last option $2 can either be the meter number or the amount or any character
              #     opt_1 ,opt_2 = $1, $2                     ##The regex makes sure 1*1*2*87689876734*20 ,this is rejected,does not take greadily like .* ,ends at the *
              #     unless customer.send(kind.pluralize).exists?(number: opt_1)
              #       if opt_1.to_i == customer.send(kind.pluralize).size + 1
              #            ##When the last value is meter number it goes here hence it is d{11}
              #       else
              #         meter = customer.send(kind.pluralize).order(:number).offset(opt_1.to_i-1).first   ###When the last value is any character ,from next_prompt ,it goes here
              #         response = last_prompt.call(meter,opt_2,customer,text,kind,option,ussd_vendor)
              #       end
              #     end
              #   end

              #         if text =~ /\A#{option}\*(\d+)\*([^*]+)\Z/  #New user with no existing accounts ,this is the next prompt call value

              #    meter = customer.send(kind.pluralize).find_by(number: $1)
              #    response = last_prompt.call(meter,$2,customer,text,kind,option,ussd_vendor) if meter   ### This is because the lambda keeps calling the method with nil attributes,it doesnt' throw an error
              #   end
              # end

         elsif text =~ /\A#{option}\*([^*]+)\*([^*]+)\*([^*]+)\Z/  ##2*1* 4*345454542*13 #add 40268611
             opt_1, opt_2, opt_3 = $1, $2, $3
             added_account = customer.send(kind.pluralize).find_by_number(opt_2)

               #if opt_1.to_i == accounts_count + 1 && added_account ##we must confirm a new account is adde3d and must confirm the new account is mapped to the customers number
               if opt_1.to_i == accounts_count && added_account ##we must confirm a new account is adde3d and must confirm the new account is mapped to the customers number
                # account = customer.get_accounts(kind).last
                 response = last_prompt.call(added_account,opt_3,customer,text,kind,option,ussd_vendor,sdp) #if meter ### To solve for this scenario ,we must check the customers meter number and make sure it doesn't equal the next value ,this is unlikely in prepaid and probable in postpaid ,however no meters will be created hence this method will not pass
              end
         end
           return response
      end

          def implement_back_button(text)   ##Used to implement the back button
           text.gsub!(/\A(\d)(\*.*\*0\*)(.*)/, '\1*\3')  ##For type 1*2*0*5 => 1*5 ##IMPORTANT: This is to return us to the sub menu page
           text.gsub!(/\A(\d)(\*.*\*0)\Z/, '\1') #For type 1*2*0 => 1*2
          end

          def online_checkout(meter,amount,customer,ussd_vendor)
            #byebug
            if ussd_vendor == "saf_ussd"
              customer.mpesas.create(mpesable: meter,amount: amount)
              response = "END You are being redirected to MPESA Menu"
            elsif ussd_vendor ==  "equitell_ussd" #{}"africas_ussd"
              customer.equities.create(equitable: meter,amount: amount)
              response = "END You are being redirected to My Money Menu"
            else
              customer.mpesas.create(mpesable: meter,amount: amount)
              response = "END You are being redirected to Mobile Money Menu"
            end

            return response
          end

          def add_home_buttons(text,response)
           if response =~ /\ACON\s/
              response + return_text(text)
            else
              response     ##Adds nothing if it is a END response
            end
          end

          def billing_rri(account,current_reading,customer,complaint_type)
              complaint = {
                 "idAccount": IncmsGccom.find_by_reference(account.number).id_payment_form,
                 "complaintType": complaint_type,
                 "text": "meterReading: #{current_reading} |USSDphone: #{customer.number}|USSD 977"
              }
              headers = {
                "Content-Type" =>  "application/json",
                "X-Requested-With" =>  "XMLHttpRequest",
                "Authorization" => "Bearer #{ENV['apim_token']}"
              }
              incms = HTTParty.post("#{ENV['apim_url']}/rccs/#{ENV['apim_version']}/complaint", body: complaint.to_json ,:headers => headers,verify: false)
              #response = "CON A new complaint with the referrence #{incms["data"]["reference"]} has been logged,kindly forward photo of your meter reading to 0702977977"
              response = "CON Your Ref: is #{incms["data"]["reference"]} Kindly forward a photo of your current meter reading to 0702977977(Whatsapp) and quote the reference provided."
          end

          def return_text(text)   ##This adds either back and home or back button to texts ,adds only home button if we are on the first sub menu
              if text =~ /\A(\d\*\d.*|3\*.*)\Z/
               "\n\n0:Back 00:Home"
              elsif text =~ /\A\d\Z/
                "\n\n00:Home"
              end
          end

    private

        def verify_and_create_meter(number,customer,kind,next_prompt,text,option)
              if kind == "meter"
                 #puts "This is the number>>>>>>>>>>>>>>>>>>>>>>#{number}"
                  if number =~ /\A\d{11}\Z/
                    meter = customer.meters.find_or_create_by(number: number)  ##TODO: After finding previous token ,lets store it on memory so as not to query incase they wanted previous token
                    response = next_prompt.call(meter,customer,text,kind,option)
                  else  ###Rejects prepaid meters with less than 11 digits or more digits or alphanumerical
                    response = "CON The meter number entered is incorrect."
                  end

              elsif kind == "account"
                      max_retries = 1
                      times_retried = 0
                       #url = "http://apim.kplc.local:80/accounts/2.0.1/#{number}/balance"
                       #url = "http://apim.kplc.local/accounts/2.0.1/#{number}/balance"

                      #text = HTTParty.get(url, :verify => false)

                      begin
                        url = "http://apim.kplc.local/accounts/2.0.1/#{number}/balance"
                        text = HTTParty.get(url, :verify => false, open_timeout: 0.1 ) ###If previous balance exists then create ,TODO: What if the meter is new and there is no balance
                        #puts ">>>>>>>>>>>>>>>>>>>>>>#{text.inspect}"
                            if text["data"]
                               account = customer.accounts.find_or_create_by(number: number) ##TODO: After finding previous token ,lets store it on memory so as not to query incase they wanted previous bill
                               response = next_prompt.call(account,customer,text,kind,option)
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

              end

            return response
        end



        # def call_api(url)
        #           max_retries = 1
        #           times_retried = 0
        #           begin
        #             response = HTTParty.get(url, :verify => false, open_timeout: 0.1 ) ###If previous balance exists then create ,TODO: What if the meter is new and there is no balance
        #           rescue StandardError
        #             ExceptionNotifier.notify_exception(StandardError)
        #             if times_retried < max_retries
        #               times_retried += 1
        #               retry
        #             end
        #           end
        #     return response
        # end














end





end










