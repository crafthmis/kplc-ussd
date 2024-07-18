class Message < ApplicationRecord
  belongs_to :customer
  after_commit :send_sms , :on => :create

  belongs_to :messageable, :polymorphic => true
  enum service: { prepaid_token: 0, postpaid_balance: 1, find_contractor: 2 , find_employee: 3 }

private 

	def send_sms 
	 #1 MessageWorker.perform_async(self.id)     ##This method makes sure it is not sent to an infinite loop as after commit will be called after every save or update
	end

end
