require 'rails_helper'

RSpec.describe Api::V1::ShortCodeController, type: :controller do


 describe "Successfull response state from safaricom" do

 	let!(:customer) { FactoryBot.create(:customer)}
 	let!(:valid_meter) {FactoryBot.create(:meter,)}
 	let!(:demand) {FactoryBot.create(:demand,request_id: "38520182",customer: customer)}

 	


	  it "When payment is successful" do 
	  	customer.meters << valid_meter 
	  		VCR.use_cassette("successful_response")  do 
	     post :index,params: {"requestId": "10180252489602044867", "requestTimeStamp": "20200806153558", "requestParam": {"data": [{"name": "Refund", "value": "0"}, {"name": "Type", "value": "DELIVERY_RECEIPT"}, {"name": "Description", "value": "DeliveredToTerminal"}, {"name": "ClientTransactionId", "value": "38520182"}, {"name": "Msisdn", "value": "254722881360"}]}, "operation": "CP_NOTIFICATION", "controller": "api/v1/short_code", "action": "index", "short_code": {"requestId": "10180252489602044867", "requestTimeStamp": "20200806153558", "requestParam": {"data": [{"name": "Refund", "value": "0"}, {"name": "Type", "value": "DELIVERY_RECEIPT"}, {"name": "Description", "value": "DeliveredToTerminal"}, {"name": "ClientTransactionId", "value": "38520182"}, {"name": "Msisdn", "value": "254722881360"}]}, "operation": "CP_NOTIFICATION"}} 
	    expect(response.status).to eql(200)  
		expect(demand.error_code).to eql(0)
	   end

	  end
	 
 end


end

