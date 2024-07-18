class Subscriber < ApplicationRecord
 # acts_as_tenant(:organization)

  belongs_to :organization #, optional: true
  belongs_to :audience
  belongs_to :contact
  belongs_to :team , optional: true

  validates_presence_of :audience
  validates_presence_of :contact

  accepts_nested_attributes_for :contact
  accepts_nested_attributes_for :team 


  #validates_uniqueness_of :contact_id, :scope => :audience_id


  
end
