class Users::InvitationsController < Devise::InvitationsController
layout "admin", :except => [:edit]

 
    # this is called when creating invitation
    # should return an instance of resource class
  # def invite_resource
  #     # skip sending emails on invite
  #     super { |user| user.skip_invitation = true }
  # end

  #   # this is called when accepting invitation
  #   # should return an instance of resource class
  # def accept_resource
  #     resource = resource_class.accept_invitation!(update_resource_params)
  #     # Report accepting invitation to analytics
  #     Analytics.report('invite.accept', resource.id)
  #     resource
  # end

  def new
	  self.resource = resource_class.new
	  render :new
  end

 def edit
    sign_out send("current_#{resource_name}") if send("#{resource_name}_signed_in?")
    set_minimum_password_length
    resource.invitation_token = params[:invitation_token]
    render :edit
  end

private
  def update_resource_params
     params.require(:user).permit(:first_name,:last_name ,:password, :password_confirmation, :invitation_token, :phone)
   end

end
