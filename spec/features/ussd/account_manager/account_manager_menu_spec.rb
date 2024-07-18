require 'rails_helper'
require 'capybara/rspec'

print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{ENV['DATABASE_URL'] }"
RSpec.describe Api::V1::UssdController, type: :controller do
  describe "When user selects prepaid option" do
	  it "It displays the prepaid menu" do 
	    post :index, params: { phoneNumber: '+254712739409',
		             serviceCode: "*384*2000#",
		             sessionId: "ATUid_26814e5e9dd5dda7b0046affa1e0a875",
		             text: "5"}
	    expect(response.body).to eql("CON Select option \n1:Prepaid meters\n2:Postpaid accounts\n\n00:Home")       
	  end
  end
end






