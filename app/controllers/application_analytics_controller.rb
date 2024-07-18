class ApplicationAnalyticsController < ApplicationController
  before_action :check_application 

  private 

  def check_application
    unless current_team.team_interfaces.map(&:name).include?("Application Monitor")
      flash[:notice] = "Forbidden, the requested resource does not exist."
      redirect_to root_path
    end
  end


end