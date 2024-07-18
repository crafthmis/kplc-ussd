class Billable < ApplicationRecord
  belongs_to :customer
  belongs_to :meter, optional: true
  belongs_to :account, optional: true

  after_create :reply_premium_sms

  private

   def reply_premium_sms

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
                            "channel": self.channel,
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
                                  #"value": self.response
                                  "value": $redis.get(self.request_id)
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
        #print ">>>>>>>>>>>>>>>>>>>>>>>>>>>#{response.inspect}\n"
        $redis.del(self.request_id)


    end

end
