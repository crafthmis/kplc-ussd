class Equity < ApplicationRecord
  belongs_to :customer
  belongs_to :equitable, polymorphic: true

  after_create :initiate_checkout



 private 
	def initiate_checkout 
		raw_xml = "<ns0:ESBMsg xmlns:acs='http://xmlns.equitybank.co.ke/ESB/EO/Resilience/Access/V1'
		xmlns:ns0='http://xmlns.equitybank.co.ke/ESB/EO/Transactions/Payment/V1'>

		<com:MsgID xmlns:com='http://xmlns.equitybank.co.ke/ESB/EO/Common/V1'>2b824e4d-de7a-440f-bd5e-
		0aed6bf6fb11</com:MsgID>

		<ns0:RqData actionCode='CreateBillPayment'>

		<ns0:Payment>
		<com:PaymentIdentifier xmlns:com='http://xmlns.equitybank.co.ke/ESB/EO/Common/V1'>
		<com:PaymentID>17967489</com:PaymentID>
		</com:PaymentIdentifier>
		<ns0:PaymentType>EazzyPayOnline</ns0:PaymentType>
		<com:Phone xmlns:com='http://xmlns.equitybank.co.ke/ESB/EO/Common/V1'>
		<com:CompleteNumber>#{customer.number}</com:CompleteNumber>
		</com:Phone>
		<com:Amount
		xmlns:com='http://xmlns.equitybank.co.ke/ESB/EO/Common/V1'>#{amount}</com:Amount>
		<com:Remarks xmlns:com='http://xmlns.equitybank.co.ke/ESB/EO/Common/V1'>Buy
		Insurance</com:Remarks>
		<com:UserID
		xmlns:com='http://xmlns.equitybank.co.ke/ESB/EO/Common/V1'>2729595587</com:UserID>
		</ns0:Payment>

		</ns0:RqData>

		</ns0:ESBMsg>" 

		  headers = {
		      "Content-Type" => "application/xml",
		      "X-Requested-With" =>  "XMLHttpRequest"      
		    }

		    auth = {
		      :username => ENV['equity_username'], 
		      :password => ENV['equity_password']
		    }

		    options = { 
		      :body => raw_xml, 
		      :basic_auth => auth, 
		      :headers => headers ,
		      :verify => false
		    }


		endpoint = "https://wsuat.equitybankgroup.com/stkpush"
		response = HTTParty.post(endpoint,options)

		xml = response.body
		received = Hash.from_xml(xml)["ESBMsg"]
		status = received["RsData"]["Status"]["Code"]

        if response["MerchantRequestID"]
          self.update_attributes(status: status)
        end
	end

end
