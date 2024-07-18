class Demand < ApplicationRecord
 include InternalApis
  belongs_to :customer
  after_create :reply_demand_sms
  #after_commit :reply_demand_sms , on: :create




  private

      #DemandWorker.perform_async(self.id) #unless self.content     ##This method makes sure it is not sent to an infinite loop as after commit will be called after every save or update,only for sidekiq
    def reply_demand_sms
      text = if self.content =~ /\Aekp(\d+)\Z/i
              find_employee($1)
            elsif self.content =~ /\Ackp(\d+)\Z/i
              find_contractor($1)
            elsif self.content =~ /\Astima\#(.+)\#(.+)\Z/i  ### report power failure $1 account ,$2 message
              report_power_failure($1,$2,self.customer.number)
            elsif self.content =~ /\A(\d+)\Z/  ##account number  $1
              find_postpaid_balance($1)
            else
              "Invalid account number. Please verify your details and try again."
            end

               #InsmmWorker.perform_async(self.id)
        authenticate_endpoint = "#{ENV['saf_sms_short_code_url']}/api/auth/login"
        request_body = {
                          "username": ENV['saf_username'],
                          "password": ENV['saf_password']
                        }
        headers = {
                    "Content-Type" =>  "application/json",
                    "X-Requested-With" =>  "XMLHttpRequest"
                  }
        response = HTTParty.post(authenticate_endpoint,:headers => headers,body: request_body.to_json, :verify => false)
        token = response["token"]


        send_sms_endpoint = "#{ENV['saf_sms_short_code_url']}/api/public/SDP/sendSMSRequest"
        request_body = {
                            "requestId": self.request_id,
                            "channel": ENV["short_code_channel"],
                            "operation": "SendSMS",
                            "requestParam": {
                              "data": [
                                {
                                  "name": "LinkId",
                                  "value": self.link_id
                                },
                                {
                                  "name": "Msisdn",
                                  "value": self.customer.number.split(//).last(12).join
                                },
                                {
                                  "name": "OfferCode",
                                  "value": self.offer_code
                                },
                                {
                                  "name": "Content",
                                  "value": text
                                },
                                {
                                  "name": "CpId",
                                  "value": ENV["kenya_power_cpid"]
                                }
                              ]
                            }
                          }
        headers = {
                      "Content-Type" =>  "application/json",
                      "X-Requested-With" =>  "XMLHttpRequest",
                      "X-Authorization" => "Bearer #{token}"
                    }
        response = HTTParty.post(send_sms_endpoint,:headers => headers,body: request_body.to_json,verify: false)
        self.update_attributes(response: text)
    end


end
