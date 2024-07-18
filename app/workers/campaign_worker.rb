class CampaignWorker
  include Sidekiq::Worker

  def perform(id)
       campaign = Campaign.find(id)
       message_failed = []
       campaign.audience.contacts.each do |contact|
           request_body = {
                "messages": campaign.message,  ##try html safe to fix LANG&apos;O
                "mobile": ["254#{contact.number}"],
                "sms_ID": contact.id
                }
            headers = {
              "Content-Type" =>  "application/json"
            }
            response = HTTParty.post("http://172.16.4.53:8080/api/send-sms",:headers => headers ,body: request_body.to_json )
            code = response["code"]
             unless code && code == 200
               message_failed << contact.id 
             end
       end
      campaign.update_column(:failed_contacts, message_failed)
      campaign.update_column(:status, "Success")
  end

end
