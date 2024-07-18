class OrganizationInterface < ApplicationRecord
  belongs_to :interface
  belongs_to :organization

  has_many :team_interfaces , :dependent => :destroy
  has_many :teams, through: :team_interfaces

  #validates_uniqueness_of :interface_id, :scope => :organization_id 




  def name 
  	interface.name.titleize
  end

end
