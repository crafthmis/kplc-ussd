class Api::V1::ShortCodeController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  before_action :set_customer

  def index
   if params["requestParam"]["data"][0]["name"] == "LinkId"
      @demand =  @customer.demands.create(
                  request_id: params["requestParam"]["data"][3]["value"],
                  request_timestamp: params["requestTimeStamp"],
                  channel: params["requestParam"]["data"][5]["value"],
                  offer_code: params["requestParam"]["data"][1]["value"],
                  link_id: params["requestParam"]["data"][0]["value"],
                  content: params["requestParam"]["data"][7]["value"]
                 )

    response = {
                  "requestId": params["requestParam"]["data"][3]["value"],
                  "responseId": @demand.id,
                  "responseTimeStamp": params["requestTimeStamp"],
                  "operation": "CP_NOTIFICATION",
                  "responseParam": {
                                      "status": "0",
                                      "statusCode": "0000",
                                      "description": "Success"
                                    }
               }
   elsif params["requestParam"]["data"][1]["value"] == "DELIVERY_RECEIPT" && @demand != nil
     @demand.update_attribute(:error_code, params["requestParam"]["data"][0]["value"])

        response = {
                  "requestId": params["requestId"],
                  "responseId": @demand.id,
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

 def delivery
   render status: 200
 end


private
  def set_customer
    if params["requestParam"]["data"][0]["name"] == "LinkId" ##initial request to get feedback
      @customer = Customer.find_or_create_by(number: params["requestParam"]["data"][8]["value"])  #Remember to eagerload here the meter numbers
    elsif params["requestParam"]["data"][1]["value"] == "DELIVERY_RECEIPT"  ##Delivery notification from safaricom
      @customer = Customer.find_by(number: params["requestParam"]["data"][4]["value"])
      @demand = @customer.demands.find_by(request_id: params["requestParam"]["data"][3]["value"])
    end

  end

end
