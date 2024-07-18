class Audience < ApplicationRecord
  #acts_as_tenant(:organization)
  #   include PublicActivity::Model
  # tracked
  belongs_to :organization

  belongs_to :team , optional: true




  has_many :subscribers 
  has_many :contacts, through: :subscribers

  accepts_nested_attributes_for :subscribers #,  allow_destroy: true , reject_if: proc {|att| att['team'].blank? }

  #validates :name, presence: true, uniqueness: true
  #validates :contacts, :length => { :minimum => 1 }

 

end
