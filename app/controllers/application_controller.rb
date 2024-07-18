class ApplicationController < ActionController::Base
 #set_current_tenant_through_filter

 before_action :authenticate_user!
 #before_action :set_organization

  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  around_action :set_time_zone, if: :current_user

  
protected

	def set_time_zone(&block)
	  Time.use_zone("Nairobi", &block)
	end

	def after_sign_in_path_for(resource)
	  root_path
	end

	def current_team
	  current_team ||=  if params[:team_id] #this is for cases such as the login 
						  Team.find(params[:team_id])
						elsif params["controller"] == "teams" && params[:id]
						   Team.find(params[:id])
						elsif params["controller"] =~ /(?<=\/)(.+)/ && params[:id] && params[:controller] != "workspaces/organizations"
						  res = $1
						  team =  if res == "teams"
								  	res.singularize.titleize.constantize.find(params[:id])
								  else
									res.singularize.titleize.constantize.find(params[:id]).team 
								  end
					   # elsif params[:controller] == "workspaces/organizations"

						end
    end   
    helper_method :current_team

    def current_application_name
      current_applications ||= current_team.return_accessible 
    end
    helper_method :current_application_name

	def current_organization
	  current_organization ||=	 if current_team
								  	current_team.organization
								  elsif params[:organization_id]
								  	Organization.find(params[:organization_id])
								  elsif params[:controller] == "workspaces/organizations"
								  	Organization.find(params[:id])
								  end
								  	
    	
	end
	helper_method :current_organization

	def owner?
	  current_organization.owner == current_user
	end

	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name, :phone])
	end 

	def set_organization 
	    current_account = current_organization
	    set_current_tenant(current_account)
	end







end
