class SmsChannel < ApplicationRecord
  #acts_as_tenant(:organization)
  belongs_to :organization

  include PublicActivity::Model
  tracked
  tracked owner: Proc.new{ |controller, model| controller.current_user }
end
