require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_account) { FactoryBot.create(:valid_account) }

  before do 
  	customer.accounts << valid_account
  end

  describe "First time Email Alert Registration" do
	  it "Prompts you for activation" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*2"}
	    expect(response.body).to eql("CON Activate Email bill alerts\n1.Activate\n\n0:Back 00:Home")       
	  end

	  it "prompts customer for email address" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	  	expect(customer.email_notification).to eql(false)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*2*1"}
	    expect(response.body).to eql("CON Input your working email address.\n\n0:Back 00:Home")       

	  end

	  it "activates email alerts and saves email address" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*2*1*dunake@gmail.com"}
	    expect(response.body).to eql("CON Email address dunake@gmail.com has been activated to receive bill alerts.\n\n0:Back 00:Home")       
	    customer.reload
	    expect(customer.email_notification).to eql(true)
	    expect(customer.email).to eql("dunake@gmail.com")
	  end

	  it "validates email format" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*2*1*dunakegmail.com"}
	    expect(response.body).to eql("CON Email address is of invalid format.\n\n0:Back 00:Home")       
	    customer.reload
	    expect(customer.email_notification).to eql(false)
	    expect(customer.email).to_not eql("dunakegmail.com")
	  end
	end

	describe "Edit email details" do
	  it "prompts change email" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	  	customer.email_notification = true 
	  	customer.save 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*2"}
	    expect(response.body).to eql("CON You are registered to receive Email bill alerts\n1.Deactive\n2.Change email\n\n0:Back 00:Home")       
	  end

	  it "prompts email address" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	  	customer.email_notification = true 
	  	customer.save 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*2*2"}
	    expect(response.body).to eql("CON Input your working email address.\n\n0:Back 00:Home")       
	  end

	  it "edit email address" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	  	customer.email_notification = true 
	  	customer.save 
	  	expect(customer.email).not_to eql("dakello@kplc.co.ke")
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*2*2*dakello@kplc.co.ke"}
	    expect(response.body).to eql("CON Email address dakello@kplc.co.ke has been activated to receive bill alerts.\n\n0:Back 00:Home")       
	    customer.reload
	    expect(customer.email).to eql("dakello@kplc.co.ke")
	  end
  end

  	describe "Deativate email alerts" do
	  it "prompts deactivation" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	  	customer.email_notification = true 
	  	customer.save 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*2"}
	    expect(response.body).to eql("CON You are registered to receive Email bill alerts\n1.Deactive\n2.Change email\n\n0:Back 00:Home")       
	  end

	  it "Users are deactivated and notified prompts deactivation" do   ##the number two is more than the current saved accounts hence systme sees that the user intends to add a account
	  	customer.email_notification = true 
	  	customer.save 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*3*2*1"}
	    expect(response.body).to eql("CON Your email has been deactivated from receiving bill alerts.\n\n0:Back 00:Home")       
	    customer.reload	
	    expect(customer.email_notification).to eql(false)
	  end
	end

end



