class InsmmWorker
  include Sidekiq::Worker
  include InternalApis

  def perform(id)
      demand = Demand.find(id)
              insmm_endpoint = "#{ENV['INSMM_URL']}/v1/public/sms-webhooks"
              request_body = {
                               "sender": demand.customer.number.split(//).last(9).join,
                               "receiver": "97771",
                               "text": demand.content,
                               "contactName": ""
                              }
              headers = {
                            "Content-Type" =>  "application/json",
                            "X-Requested-With" =>  "XMLHttpRequest"
                        }
              response = HTTParty.post(insmm_endpoint,:headers => headers,body: request_body.to_json, :verify => false)
              insmm_id = response["id"]
              insmm_bool = response["processed"]
             demand.update_attributes(insmm: insmm_bool, insmm_id: insmm_id)
  end

end