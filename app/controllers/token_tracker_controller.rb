class TokenTrackerController < ApplicationController
  before_action :check_application 

  private 



  def check_application
    unless current_team.team_interfaces.map(&:name).include?("Token Tracker")
      flash[:notice] = "Forbidden, the requested resource does not exist."
      redirect_to root_path
    end
  end

end
