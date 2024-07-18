require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer,number: "254712829808") }
  let(:request) { FactoryBot.create(:request,customer: customer)}
  let(:valid_account) { FactoryBot.create(:valid_account,number: "8293394") }

  before do 
	customer.accounts << valid_account
  end

  describe "My current bill" do
	  it "It displays the list of saved accounts" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*1"}
	    expect(response.body).to eql("CON Select account\n1:#{valid_account.number}\n2:Add account number\n\n0:Back 00:Home")       
	  end
	 it "add a new account number" do 
	 	VCR.use_cassette("postpaid/current_bill")  do 
	  	expect(customer.accounts.count).to eql(1)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*1*2*1"}
		expect(response.body).to eql("CON Account: 1\n Name: ANONIMO ANONIMO ANONIMO\n Balance: -2,248,681.30 Ksh Overpayment\nLatest Bill:  Ksh\n Due Date: \n\n0:Back 00:Home")       
		customer.accounts.reload
	    expect(customer.accounts.count).to eql(2)  
	    end    
	  end
  end

    describe "Pay my bill" do
	  it "It displays the list of saved accounts" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*2"}
	    expect(response.body).to eql("CON Select account\n1:#{valid_account.number}\n2:Add account number\n\n0:Back 00:Home")       
	  end
	 it "add a new account number" do 
	 	VCR.use_cassette("postpaid/pay_my_bill")  do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*2*2"}
		expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")       
	
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*2*2*47042221"}
		expect(response.body).to eql("CON Enter amount to pay\n\n0:Back 00:Home")       
	    
	    customer.accounts.reload
	  	expect(customer.accounts.count).to eql(2)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*2*2*47042221*12"}
		expect(response.body).to eql("END You are being redirected to MPESA Menu") 
		end      
	  end
  end

end












