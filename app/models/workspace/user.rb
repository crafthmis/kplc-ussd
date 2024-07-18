class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :projects 
  has_many :teams 

  has_many :organization_users
  has_many :organizations, through: :organization_users
  

  has_many :campaigns 
  delegate :bulk, :api, :schedule ,:survey, to: :campaigns

  has_many :memberships
  has_many :teams, through: :memberships

 



  # ANALYTICSADMIN = { "Analytics" => "analytics" ,"Analytics Admin" => "analytics_admin" } 
  # BIADMIN = { "Business Intelligence" => "business_intelligence", "Business Intelligence Admin" => "bi_admin" }
  # CONTACTSADMIN = {"Contact Center" => "contact_center" ,"Contact Center Admin" => "contact_admin" }
  


   def assign_default_role  ##token_tracker ,control_sms ,business_intelligence ,monitor , analytic_admin,control_admin,bi_admin,super_admin
     self.add_role(:user) if self.roles.blank?
   end


   def return_workspace_ids
    team_id = []
    team_id << Membership.where(user_id: id).pluck(:team_id)
    team_id << Team.where(owner_id: id).pluck(:id)
    return team_id.flatten!
   end

end
