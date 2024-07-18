require 'rails_helper'

RSpec.describe Api::V1::UssdController, type: :controller do

 describe "Display main menu ,load or create customer ,save request to database" do
	  it "Displays the main menu correctly" do 
	    post :index, params: { phoneNumber: '+254712739409',
	             serviceCode: "*384*2000#",
	             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
	             text: ""}
	    expect(response.status).to eql(200)   
	    expect(response.body).to eql("CON Welcome to Kenya Power\n1:Prepaid Services\n2:Postpaid Services\n3:Report Power-Failure\n4:Jua For Sure\n5:Manage Accounts")       
	  end
	end
end
