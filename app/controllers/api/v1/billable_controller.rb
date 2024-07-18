class Api::V1::BillableController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  #before_action :set_customer
  #before_action :set_billable

  def index

   if params["requestParam"]["data"][0]["name"] == "LinkId"
     customer = Customer.find_by(number: params["requestParam"]["data"][8]["value"])

         request_id = params["requestParam"]["data"][3]["value"]
         response = $redis.get(request_id)
         #print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Response: #{response}"
         billable = customer.billables.create(
                  request_id: request_id,
                  #response_id: billable.id,
                  request_timestamp: params["requestTimeStamp"],
                  channel: params["requestParam"]["data"][5]["value"],
                  offer_code: params["requestParam"]["data"][1]["value"],
                  link_id: params["requestParam"]["data"][0]["value"],
                  content: params["requestParam"]["data"][7]["value"],
                  response: response
                 )

    response = {
                  "requestId": params["requestId"],
                  "responseId": billable.id,
                  "responseTimeStamp": params["requestTimeStamp"],
                  "operation": "CP_NOTIFICATION",
                  "responseParam": {
                                      "status": "0",
                                      "statusCode": "0000",
                                      "description": "Success"
                                    }
               }
   elsif params["requestParam"]["data"][1]["value"] == "DELIVERY_RECEIPT" #&& @billable != nil
     if params["requestParam"]["data"][0]["name"] == "Refund"
       @customer = Customer.find_by(number: params["requestParam"]["data"][4]["value"])
       #print ">>>>>>>>>>>>>>>>>>>>>>>Request param 4: #{params["requestParam"]["data"][4]["value"]}\n"
       @billable = @customer.billables.find_by(request_id: params["requestParam"]["data"][3]["value"])
       @billable.update_column(:error_code, params["requestParam"]["data"][2]["value"])
     else
       @customer = Customer.find_by(number: params["requestParam"]["data"][3]["value"])
       #print ">>>>>>>>>>>>>>>>>>>>>>>Request param 3: #{params["requestParam"]["data"][3]["value"]}\n"
       @billable = @customer.billables.find_by(request_id: params["requestParam"]["data"][0]["value"])
       @billable.update_column(:error_code, params["requestParam"]["data"][2]["value"])
     end


        response = {
                  "requestId": params["requestId"],
                  "responseId": @billable.id,
                  "responseTimeStamp": params["requestTimeStamp"],
                  "operation": "CP_NOTIFICATION",
                  "responseParam": {
                                      "status": "0",
                                      "statusCode": "0000",
                                      "description": "Success"
                                    }
               }
   else

    response = {}

   end




    render  json: response,status: :ok
  end

 #def delivery
 #  render status: 200
 #end


private
  #def set_customer
    #if params["requestParam"]["data"][0]["name"] == "LinkId" ##initial request to get feedback
      #@customer = Customer.find_or_create_by(number: params["requestParam"]["data"][8]["value"])  #Remember to eagerload here the meter numbers
     # @customer = Customer.find_by(number: params["requestParam"]["data"][8]["value"])  #Remember to eagerload here the meter numbers
    #elsif params["requestParam"]["data"][1]["value"] == "DELIVERY_RECEIPT"  ##Delivery notification from safaricom
    #  @customer = Customer.find_by(number: params["requestParam"]["data"][4]["value"])
   #   @billable = @customer.billables.find_by(request_id: params["requestParam"]["data"][3]["value"])
    #end
  #end

  #def set_billable
  #  @billable = @customer.billables.find_by(request_id: params["requestParam"]["data"][3]["value"])
 # end


end
