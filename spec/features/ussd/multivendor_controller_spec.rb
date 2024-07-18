require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do

 describe "The ussd methods work for multiple vendors" do
	  it "Africas Talking API" do 
	    post :index, params: { phoneNumber: '+254712739409',
	             serviceCode: "*384*2000#",
	             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             text: ""}
	    expect(response.status).to eql(200)   
	    expect(response.body).to eql("CON Welcome to Kenya Power\n1:Prepaid Services\n2:Postpaid Services\n3:Report Power-Failure\n4:Jua For Sure\n5:Manage Accounts")       
	  end

	  it "Safaricom test API environment with *167*59#" do 
	    post :index, params: { MSISDN: '+254712739409',
	             SESSION_ID: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             USSD_STRING: "59"}
	    expect(response.status).to eql(200)   
	    expect(response.body).to eql("CON Welcome to Kenya Power\n1:Prepaid Services\n2:Postpaid Services\n3:Report Power-Failure\n4:Jua For Sure\n5:Manage Accounts")       
	  end

	  it "Safaricom test API environment with data on string" do 
	    post :index, params: { MSISDN: '+254712739409',
	             SESSION_ID: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             USSD_STRING: "59*1"}
	    expect(response.status).to eql(200)   
	    expect(response.body).to eql("CON Select option \n1:Buy Token\n2:Latest Token\n\n00:Home")       
	  end

	  it "Safaricom production environment" do 
	    post :index, params: { MSISDN: '+254712739409',
	             SESSION_ID: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             USSD_STRING: ""}
	    expect(response.status).to eql(200)   
	    expect(response.body).to eql("CON Welcome to Kenya Power\n1:Prepaid Services\n2:Postpaid Services\n3:Report Power-Failure\n4:Jua For Sure\n5:Manage Accounts")       
	  end
	end

	 describe "The ussd methods works with both get and post requests" do
	  it "Africas Talking API POST request" do 
	    post :index, params: { phoneNumber: '+254712739409',
	             serviceCode: "*384*2000#",
	             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             text: ""}
	    expect(response.status).to eql(200)   
	    expect(response.body).to eql("CON Welcome to Kenya Power\n1:Prepaid Services\n2:Postpaid Services\n3:Report Power-Failure\n4:Jua For Sure\n5:Manage Accounts")       
	  end


	  it "Safaricom API get request" do 
	    get :index, params: { MSISDN: '+254712739409',
	             SESSION_ID: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             USSD_STRING: ""}
	    expect(response.status).to eql(200)   
	    expect(response.body).to eql("CON Welcome to Kenya Power\n1:Prepaid Services\n2:Postpaid Services\n3:Report Power-Failure\n4:Jua For Sure\n5:Manage Accounts")       
	  end
	end

end
