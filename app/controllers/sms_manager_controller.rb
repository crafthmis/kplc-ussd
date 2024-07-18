class SmsManagerController < ApplicationController
  layout "admin"
  before_action :check_application 

  private 

  def check_application
    unless current_team.allow_access("sms_manager")
      flash[:notice] = "Forbidden, the requested resource does not exist."
      redirect_to root_path
    end
  end

end
