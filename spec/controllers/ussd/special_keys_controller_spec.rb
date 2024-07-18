require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:valid_meter) { FactoryBot.build(:valid_meter) }

  before do 
  	customer.meters << valid_meter
  end

  describe "User special keys" do
	 it "Can go back to home menu" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*00"}
	    expect(response.body).to eql("CON Welcome to Kenya Power\n1:Prepaid Services\n2:Postpaid Services\n3:Report Power-Failure\n4:Jua For Sure\n5:Manage Accounts")       
	  end

	 it "Can go back to sub menu" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*0*1"}
	    expect(response.body).to eql("CON Select meter\n1:#{valid_meter.number}\n2:Add meter number\n\n0:Back 00:Home")       
	  end

	 it "can go back to sub menu after going back to home menu" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*0*1*5*0*2*0*1*00*1*1*0"}
	    expect(response.body).to eql("CON Select option \n1:Buy Token\n2:Latest Token\n\n00:Home")       
	  end

	  it "does not confuse mpesa payments with zeros as back button" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*1*1*10"}
	    expect(response.body).to eql("END You are being redirected to MPESA Menu")       
	  end

	  it "Goes back to correct menu after inputs of meter numbers ending with zero " do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*1*3*12675898760*0"}
	    expect(response.body).to eql("CON Select option \n1:Prepaid meters\n2:Postpaid accounts\n\n00:Home")       
	  end
	end


	describe "Back keys returns users to sub menu page" do
	 it "prepaid serivces" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "1*2*0"}
	    expect(response.body).to eql("CON Select option \n1:Buy Token\n2:Latest Token\n\n00:Home")       
	  end

	 it "postpaid services" do 
	 	post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "2*1*0"}
	    expect(response.body).to eql("CON Select option \n1.My bill\n2.Pay bill\n3.Bill alerts\n4.Self reading\n\n00:Home")       
	  end

	 it "Report power Power-Failure" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "3*1*0"}
	    expect(response.body).to eql("CON Select account type\n1:Prepaid\n2:Postpaid\n\n00:Home")       
	  end

	  it "Jua For Sure" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "4*1*1*0"}
	    expect(response.body).to eql("CON Select Kenya Power employee to verify\n1.Staff \n2.Contractor\n\n00:Home")       
	  end

	  it "Account Manager" do 
	    post :index, params: { phoneNumber: customer.number,
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5*1*0"}
	    expect(response.body).to eql("CON Select option \n1:Prepaid meters\n2:Postpaid accounts\n\n00:Home")       
	  end

	end


end



	





