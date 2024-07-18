require 'rails_helper'
RSpec.describe Api::V1::UssdController, type: :controller do
		let!(:customer_1) { FactoryBot.create(:customer,number: "254726130418") }
		let!(:valid_meter_1) { FactoryBot.build(:valid_meter) }

		before do 
	    	customer_1.meters << valid_meter_1
		end

	describe "User has meters linked to phone" do
		  it "It displays linked meter numbers" do 
		    post :index, params: { phoneNumber: customer_1.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*1"}
		    expect(response.body).to eql("CON Select meter\n1:#{valid_meter_1.number}\n2:Add meter number\n\n0:Back 00:Home")       
		  end

		  it "You can choose a meter number" do 
		    post :index, params: { phoneNumber: customer_1.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*1*1"}
		    expect(response.body).to eql("CON Enter Amount In Ksh\n\n0:Back 00:Home")       
		  end

		  it "You can enter amount to pay" do 
		  	VCR.use_cassette("paying_from_meter_selection") do
		    expect(Mpesa.count).to eql(0)
		    post :index, params: { phoneNumber: customer_1.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*1*1*10"}
		    expect(response.body).to eql("END You are being redirected to MPESA Menu")   
		    mpesa = Mpesa.last
		    expect(mpesa.amount).to eql("10")
		    #expect(MpesaWorker).to have_enqueued_sidekiq_job(mpesa.id)
		    end
		  end
	 end


	describe "adding an extra meter on the list" do
	  it "The last item on the array list is an option to add more meters" do 
	    post :index, params: { phoneNumber: customer_1.number,
	             serviceCode: "*384*2000#",
	             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             text: "1*1*2"}
	    expect(response.body).to eql("CON Input your meter number\n\n0:Back 00:Home")       
	  end

	  it "After entering meter number you are promted for the amount" do 
	  	    post :index, params: { phoneNumber: customer_1.number,
	             serviceCode: "*384*2000#",
	             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             text: "1*1*2*12357898098"}
	     expect(response.body).to eql("CON Enter Amount In Ksh\n\n0:Back 00:Home")
	  end

	  it "After entering amount you are redirected to mpesa" do 
	  	VCR.use_cassette("adding_account_checkout") do
  	    post :index, params: { phoneNumber: customer_1.number,
             serviceCode: "*384*2000#",
             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
             text: "1*1*2*12357898098"}
	    expect(response.body).to eql("CON Enter Amount In Ksh\n\n0:Back 00:Home")

  	    post :index, params: { phoneNumber: customer_1.number,
             serviceCode: "*384*2000#",
             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
             text: "1*1*2*12357898098*100"}
	     expect(response.body).to eql("END You are being redirected to MPESA Menu")
	     mpesa = Mpesa.last
	     expect(mpesa.amount).to eql("100")
	     #expect(MpesaWorker).to have_enqueued_sidekiq_job(mpesa.id)
	     end
	  end
  end

end










