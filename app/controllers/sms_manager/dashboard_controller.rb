class SmsManager::DashboardController < SmsManagerController
  layout "admin"
  before_action :set_team
  def index
    #@teams_id = current_user.teams.pluck(:id) #Team.where('id = ?', current_user.team_id)
    @campaigns = current_organization.campaigns.all #Project.where('team_id = ?', current_user.team_id)
  end


  private 

  def set_team 
  	@team = current_organization.teams.find(params[:team_id])
  end
end
