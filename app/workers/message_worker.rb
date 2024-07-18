class MessageWorker
  include Sidekiq::Worker
  include InternalApis

  def perform(id)
      message = Message.find(id)
      text =  if message.service == "prepaid_token"
                find_previous_token(message.messageable.number)
              elsif message.service == "postpaid_balance"
                find_postpaid_balance(message.messageable.number)
              elsif message.service == "find_contractor"
                find_contractor(message.content)
              elsif message.service == "find_employee"
                find_employee(message.content) 
              end

    if text 
      request_body = {
              "messages": text.to_s.html_safe,  ##try html safe to fix LANG&apos;O
              "mobile": [message.customer.number.split(//).last(12).join],
              "sms_ID": message.id
              }
      headers = {
        "Content-Type" =>  "application/json"
      }
      response = HTTParty.post("http://172.16.4.53:8080/api/send-sms",:headers => headers ,body: request_body.to_json )
      message.update_attributes(content: text ,code: response["code"])  ##we use update_column because it skips callbacks hence the method will not be called again after commit leading to infinite SMS
    end
  end

end
