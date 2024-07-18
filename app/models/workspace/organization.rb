class Organization < ApplicationRecord
  belongs_to :owner, class_name: "User" 

  accepts_nested_attributes_for :owner

  has_many :organization_interfaces
  has_many :interfaces, through: :organization_interfaces

  

  has_many :team_interfaces 
  has_many :teams, through: :team_interfaces

  has_many :organization_users 
  has_many :users, through: :organization_users

  has_many :campaigns
  has_many :contacts 
  has_many :subscribers 
  has_many :audiences
  has_many :sms_templates 
  has_many :memberships 

  validates :name, presence: true, uniqueness: true 

  accepts_nested_attributes_for :organization_interfaces, allow_destroy: true


  #has_many :invitations
end
