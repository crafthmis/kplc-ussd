class Team < ApplicationRecord
 # we want projects within a team to be destroyed if a team is 
  #has_many :projects, dependent: :destroy 
    # teams can have many users
 # acts_as_tenant(:organization)
 belongs_to :organization

  # include PublicActivity::Model
  # tracked
  # tracked owner: Proc.new{ |controller, model| controller.current_user }



  has_many :team_interfaces
  has_many :organization_interfaces , -> { distinct } , through: :team_interfaces 


  belongs_to :owner, class_name: "User"

  has_many :memberships , :dependent => :destroy
  has_many :users , -> { distinct } , through: :memberships 

  #validates :name, presence: true, uniqueness: true
  #validates :organization_interfaces, :length => { :minimum => 1 }

  #validates :users, :length => { :minimum => 1 }
 

 

  has_many :audiences
  has_many :campaigns 

  has_many :subscribers, inverse_of: :team
  has_many :contacts, -> { distinct } , through: :subscribers



  has_many :sms_templates
  accepts_nested_attributes_for :team_interfaces, allow_destroy: true



  APPLICATIONS = { "Application Analytics" => "application_analytics",
                  "Business Intelligence" => "business_intelligence",
                  "SMS Manager" => "sms_manager",
                  "Token Tracker" => "token_tracker",
                  "USSD Manager" => "ussd_manager" }

  ROOTURL = { "application_analytics" => "application_analytics_dashboard_index_path",
              "application_monitor" => "application_analytics_dashboard_index_path",
              "business_intelligence" => "team_business_intelligence_dashboard_index_path",
              "sms_manager" => "team_sms_manager_dashboard_index_path",
              "token_tracker" => "token_tracker_dashboard_index_path",
              "ussd_manager" => "team_sms_manager_dashboard_index_path" }

 
   def get_url
    url = {}
    team_interfaces.each do |interface|
      url[interface.name] = ROOTURL[interface.name.parameterize.underscore]
    end
    return url 
  end

  def allow_access(interface)
    team_interfaces.map(&:parameterized_name).include?(interface)
  end

  def return_accessible 
    team_interfaces.map(&:parameterized_name).uniq
  end

  def return_titles
    team_interfaces.map(&:parameterized_name)
  end





  # To create a team I need nested forms in which I can invite users. This is what allows us to do such a thing.
  #accepts_nested_attributes_for :owner, allow_destroy: true
end
