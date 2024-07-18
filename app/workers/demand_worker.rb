class DemandWorker
  include Sidekiq::Worker
  include InternalApis

  def perform(id)
      demand = Demand.find(id)
      text = if demand.content =~ /\Aekp(\d+)\Z/i
              find_employee($1)
            elsif demand.content =~ /\Ackp(\d+)\Z/i
              find_contractor($1)
            elsif demand.content =~ /\Astima\#(.+)\#(.+)\Z/i  ### report power failure $1 account ,$2 message
              report_power_failure($1,$2)
            elsif demand.content =~ /\A(\d+)\Z/  ##account number  $1
              find_postpaid_balance($1)
            else
              insmm_endpoint = "http://insmm.kplc.local:81/smm-api/v1/public/sms-webhooks"
              request_body = {
                               "sender": self.customer.number.split(//).last(9).join,
                               "receiver": "97771",
                               "text": self.content,
                               "contactName": ""
                              }
              headers = {
                            "Content-Type" =>  "application/json",
                            "X-Requested-With" =>  "XMLHttpRequest"
                        }
              response = HTTParty.post(insmm_endpoint,:headers => headers,body: request_body.to_json, :verify => false)
              insmm_id = response["id"]
              insmm_bool = response["processed"]
             self.update_attributes(insmm: insmm_bool, insmm_id: insmm_id)

              "SMS format is invalid."
            end

        authenticate_endpoint = "#{ENV['saf_sms_short_code_url']}/api/auth/login"
        request_body = {
                          "username": ENV['saf_username'],
                          "password": ENV['saf_password']
                        }
        headers = {
                    "Content-Type" =>  "application/json",
                    "X-Requested-With" =>  "XMLHttpRequest"
                  }
        response = HTTParty.post(authenticate_endpoint,:headers => headers,body: request_body.to_json)
        token = response["token"]


        send_sms_endpoint = "#{ENV['saf_sms_short_code_url']}/api/public/SDP/sendSMSRequest"
        request_body = {
                            "requestId": demand.request_id,
                            "channel": ENV["short_code_channel"],
                            "operation": "SendSMS",
                            "requestParam": {
                              "data": [
                                {
                                  "name": "LinkId",
                                  "value": demand.link_id
                                },
                                {
                                  "name": "Msisdn",
                                  "value": demand.customer.number.split(//).last(12).join
                                },
                                {
                                  "name": "OfferCode",
                                  "value": ENV["short_code_offer_code"]
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
        demand.update_attributes(response: text)


  end

end