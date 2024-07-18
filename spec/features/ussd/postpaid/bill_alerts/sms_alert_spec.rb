require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_account) { FactoryBot.create(:valid_account) }

  before do 
  	customer.accounts << valid_account
  end

  describe "SMS Alert" do
	  it "Prompts for alert type" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3"}
	    expect(response.body).to eql("CON Select alert type\n1. SMS alert\n2. Email alert\n\n0:Back 00:Home")       
	  end
	  it "Prompts you for activation" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*1"}
	    expect(response.body).to eql("CON Activate SMS bill alerts\n1.Activate\n\n0:Back 00:Home")       
	  end

	  it "activates customer for sms alerts" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	  	expect(customer.sms_notification).to eql(false)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*1*1"}
	    expect(response.body).to eql("CON Your number has been activated to receive bill alerts.\n\n0:Back 00:Home")       
	    customer.reload
	    expect(customer.sms_notification).to eql(true)
	  end

	  it "deactivates customer from sms alerts" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	  	customer.sms_notification = true 
	  	customer.save 
	  	expect(customer.sms_notification).to eql(true)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*1*1"}
	    expect(response.body).to eql("CON Your number has been deactivated from receiving bill alerts.\n\n0:Back 00:Home")       
	    customer.reload
	    expect(customer.sms_notification).to eql(false)
	  end


  end

end



