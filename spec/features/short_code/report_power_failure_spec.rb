require 'rails_helper'

RSpec.describe Api::V1::ShortCodeController, type: :controller do


 describe "Reporting power failure" do

 	#let!(:customer) { FactoryBot.create(:customer)}
 	#let!(:meter) {FactoryBot.create(:meter)}

	  it "When payment is successful" do 
	  	expect(Customer.all.size).to eql(0)
	  	expect(Demand.all.size).to eql(0)
	    post :index,params: {
							   "requestId":"39856",
							   "requestTimeStamp":"20200205185725",
							   "requestParam":{
											      "data":[
											         {
											            "name":"LinkId",
											            "value":"0007311018784515661497991"
											         },
											         {
											            "name":"OfferCode",
											            "value":"001007300127"
											         },
											         {
											            "name":"RefernceId",
											            "value":"1018784515649514444"
											         },
											         {
											            "name":"ClientTransactionId",
											            "value":"39856"
											         },
											         {
											            "name":"Language",
											            "value":"1"
											         },
											         {
											            "name":"Channel",
											            "value":"1"
											         },
											         {
											            "name":"Type",
											            "value":"NOTIFY_LINKID"
											         },
											         {
											            "name":"USER_DATA",
											            "value":"Stima#1#No power in muthurwa, uthiru Kindly assist"
											         },
											         {
											            "name":"Msisdn",
											            "value":"254712829808"
											         }
											      ]
											   },
							 "operation":"CP_NOTIFICATION"
							}
 
		expect(response.status).to eql(200)  
		expect(Customer.all.size).to eql(1)
	  	expect(Demand.all.size).to eql(1)

	  	demand = Demand.first
	  	customer = Customer.first

	  	expect(customer.number).to eql("254748250794")

		expect(demand.response).to eql("39856")

	  end
	 
 end


end

