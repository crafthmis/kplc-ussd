require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:valid_account) { FactoryBot.build(:valid_account,number: "592833") }
  let(:valid_account_2) { FactoryBot.build(:valid_account,number: "1") }

  describe "Creating postpaid accounts" do
	 it "With no linked accounts" do 
	 	VCR.use_cassette("postpaid/creating_postpaid_with_no_linked_accounts")  do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2"}
	    expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")    

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2*47042221"}
	    expect(response.body).to eql("CON Account No:47042221 has been added to this profile.\n\n0:Back 00:Home") 
	    customer.reload 
	    expect(customer.accounts.size).to eql(1)
	    end
	  end

	it "With a linked account" do 
		VCR.use_cassette("postpaid/creating_postpaid_with_linked_accounts")  do 
		customer.accounts << valid_account 
		expect(customer.accounts.size).to eql(1) 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2*2"}
	    expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2*2*47042221"}
	    expect(response.body).to eql("CON Account No:47042221 has been added to this profile.\n\n0:Back 00:Home")       
	    customer.accounts.reload
	    expect(customer.accounts.size).to eql(2) 
	    end
	end

	it "With wrong account number" do 
		VCR.use_cassette("postpaid/wrong_account_number")  do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2"}
	    expect(response.body).to eql("CON Input your account number\n\n0:Back 00:Home")    

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2*4704222234"}
	    expect(response.body).to eql("CON The account number could not be found, kindly call us on 97771.\n\n0:Back 00:Home") 
	    customer.accounts.reload 
	    expect(customer.accounts.size).to eql(0)
	    end	
	end

	it "Last method returns nil when user types more characters" do 
	    customer.accounts << valid_account

	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2*1*4353"}
	    expect(response.body).to eql("null")       
	end
  end


  describe "Removing prepaid accounts" do
      before do 
      	customer.accounts << valid_account 
      end

	it "With a linked account" do
    	expect(customer.accounts.size).to eql(1) 
		
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2"}
	    expect(response.body).to eql("CON Select account\n1:#{valid_account.number}\n2:Add account number\n\n0:Back 00:Home")
    
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2*1"}
	    expect(response.body).to eql("CON Account No:#{valid_account.number} has been removed from this profile.\n\n0:Back 00:Home")       
	    expect(customer.accounts.size).to eql(0)
	end
  end



 describe "Removing prepaid accounts with similar index account number" do

	it "Creating an account number with index 1" do 
		VCR.use_cassette("postpaid/Creating_an_account_number_with_index_1")  do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2*1"}
	    expect(response.body).to eql("CON Account No:1 has been added to this profile.\n\n0:Back 00:Home") 
	    end      
	end

   it "Removing an account with index of 1" do
     	customer.accounts << valid_account
  	    customer.accounts << valid_account_2
    	expect(customer.accounts.size).to eql(2) 
		
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2"}
	    expect(response.body).to eql("CON Select account\n1:#{valid_account_2.number}\n2:#{valid_account.number}\n3:Add account number\n\n0:Back 00:Home")
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*2*1"}
	    expect(response.body).to eql("CON Account No:#{valid_account_2.number} has been removed from this profile.\n\n0:Back 00:Home")       
	    expect(customer.accounts.size).to eql(1)
	end
  end

end









