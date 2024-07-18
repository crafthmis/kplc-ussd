require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:valid_account) { FactoryBot.build(:valid_account) }


  describe "Reporting postpaid accounts" do
	 it "With no linked accounts" do 
	 	VCR.use_cassette("power_failure/postpaid_report_failure")  do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*2"}
	    expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")    

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*2*#{valid_account.number}"}
	    expect(response.body).to eql("CON The transaction took too long to complete.\n\n0:Back 00:Home") 
	    customer.reload 
	    expect(customer.accounts.count).to eql(1)
	    end
	  end

	it "With a linked account" do 
	  customer.accounts << valid_account 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*2"}
	    expect(response.body).to eql("CON Select account\n1:#{valid_account.number}\n2:Add account number\n\n0:Back 00:Home") 

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*2*1"}
	    expect(response.body).to eql("CON The transaction took too long to complete.\n\n0:Back 00:Home")       
	end

	it "Last method returns nil when user types more characters" do 
	    customer.accounts << valid_account 

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*2*1*4353"}
	    expect(response.body).to eql("null")       
	end
  end

end









