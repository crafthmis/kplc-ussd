class Membership < ApplicationRecord
  #acts_as_tenant(:organization)
  belongs_to :team
  belongs_to :user

  # include PublicActivity::Model
  # tracked

  
end
