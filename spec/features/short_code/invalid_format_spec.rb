require 'rails_helper'

RSpec.describe Api::V1::ShortCodeController, type: :controller do


 describe "Safaricoms callback URL for 9771" do

	  it "When payment is successful" do 
       VCR.use_cassette("invalid_format")  do
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
											            "value":"254712829808"
											         }
											      ]
											   },
							 "operation":"CP_NOTIFICATION"
							}
   	    demand = Demand.first
		expect(DemandWorker).to have_enqueued_sidekiq_job(demand.id)

		# DemandWorker.drain
		# demand.reload
		# expect(demand.response).to eql("DL test")

	  end
	end
	 
 end


end

