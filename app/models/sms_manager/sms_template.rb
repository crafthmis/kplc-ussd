class SmsTemplate < ApplicationRecord
	#acts_as_tenant(:organization)
	belongs_to :team 

  # include PublicActivity::Model
  # tracked
  # tracked owner: Proc.new{ |controller, model| controller.current_user }

end
