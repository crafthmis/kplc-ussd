class RequestWorker
include Sidekiq::Worker

  def perform(session_id,phone_number,ussd_string,kind,customer_id)
	customer = Customer.find(customer_id)
    r = customer.requests.find_or_create_by( session_id: session_id )
    r.text = ussd_string
	r.kind = kind
	r.save
  end
end
