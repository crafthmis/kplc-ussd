require 'rails_helper'

RSpec.describe Api::V1::ShortCodeController, type: :controller do


 describe "Safaricoms callback URL for 9771" do

 	# let!(:customer) { FactoryBot.create(:customer)}
 	# let!(:meter) {FactoryBot.create(:meter)}

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
											            "value":"DL test"
											         },
											         {
											            "name":"Msisdn",
											            "value":"254748250794"
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

		expect(demand.request_id).to eql("39856")
		expect(demand.request_timestamp).to eql("20200205185725")
		expect(demand.channel).to eql("1")
		expect(demand.offer_code).to eql("001007300127")
		expect(demand.link_id).to eql("0007311018784515661497991")
		expect(demand.content).to eql("DL test")
		expect(DemandWorker).to have_enqueued_sidekiq_job(demand.id)
	  end
	 
 end


end

