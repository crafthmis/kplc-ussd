class ApplicationAnalytics::AdminController < ApplicationAnalyticsController
  before_action :check_admin 

  private 

  def check_admin
    if current_app != "Application Analytics"
      flash[:notice] = "Forbidden, the requested resource does not exist."
      redirect_to root_path
    end
  end
end