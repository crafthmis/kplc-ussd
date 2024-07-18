class TeamInterface < ApplicationRecord
  belongs_to :team 
  belongs_to :organization_interface 
  belongs_to :organization


  validates_uniqueness_of :organization_interface_id, :scope => :team_id


  def name 
  	organization_interface.name 
  end


  def parameterized_name 
    organization_interface.name.parameterize.underscore
  end

end
