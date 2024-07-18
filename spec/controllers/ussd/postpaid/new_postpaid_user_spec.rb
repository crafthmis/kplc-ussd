require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:valid_account) { FactoryBot.build(:valid_account) }

  describe "My current bill" do
	 it "Prompts user to input the account number" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*1"}
	    expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")       
	  end

	it "Links account to profile" do 
		VCR.use_cassette("postpaid/links_account_to_profile")  do 
		expect(customer.accounts.count).to eql(0)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*1*#{valid_account.number}"}
	    expect(response.body).to eql("CON Account: 47042221\n Name: ROBERT JALLANG&apos;O AKELLO\n Balance: -1.33 Ksh Overpayment\nLatest Bill: 615 Ksh\n Due Date: 2020-03-06\n\n0:Back 00:Home")       
	    expect(customer.accounts.count).to eql(1)
	    end
	end
  end

  describe "Pay my bill" do
	 it "Prompts user to input the account number" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*2"}
	    expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")       
	  end

	it "Links account to profile" do 
		VCR.use_cassette("postpaid/links_account_to_profile")  do 
		expect(customer.accounts.count).to eql(0)
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*2*#{valid_account.number}"}
	    expect(response.body).to eql("CON Enter amount to pay\n\n0:Back 00:Home")       
	    expect(customer.accounts.count).to eql(1)
	    end
	end
  end

end









