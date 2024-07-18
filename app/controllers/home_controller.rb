class HomeController < ApplicationController
 layout :resolve_layout
 before_action :find_team_ids, only: [:index ,:create]
 before_action :set_teams, only: [:index ,:create]

 #before_action :check_application ,only: [:index]

  def index
  end
  
  def create 
	    if @team_ids.include?(params[:workspace_id].to_i)
         @team ||= Team.find(params[:workspace_id])

         flash[:notice] = "Welcome to your #{@team.name.titleize} workspace"
         accessible = @team.return_accessible.first
         home_path = if accessible
                        dynamic_dashboard_link(accessible,@team)
                      else
                        team_path(params[:workspace_id])
                      end
	       redirect_to home_path
	    else   
	      #flash.now[:danger] = "Access denied you do not have sufficient privileges"
        flash.now[:danger] = "This software is under maintenance."
	      render :index 
	    end   
   end

  def show  
    flash.now[:info] = "You have existed #{current_app} workspace"
    session[:current_app] = nil 
    render :index
   	redirect_to root_url, info: "Workspace exited."
  end

 private 

  def find_team_ids 
    @team_ids ||= current_user.return_workspace_ids 
  end

  def set_teams
    @teams ||= Team.find( @team_ids )
  end

  def dynamic_dashboard_link(accessible,team)
    send "team_#{accessible}_dashboard_index_path", team  
  end

  # def check_application
  #   if  current_app 
  #     redirect_to User::ROOTURL[current_app]
  #   end
  # end

  def resolve_layout
    case action_name
    #when "new", "create"
    #  "some_layout"
    when "index"
      "application"
    else
      "application"
    end
  end


end



