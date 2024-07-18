class OrganizationsController < ApplicationController
  
  layout "application"
  skip_before_action :authenticate_user!,only: [:new ,:create]


  def new
    @organization = Organization.new
    @organization.build_owner
  end

  def create
    @organization = Organization.new(organization_params)
    
    respond_to do |format|
      if @organization.save
         sign_in(account.owner)
        format.html { redirect_to  root_url notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Only allow a list of trusted parameters through.
    def organization_params
      params.require(:organization).permit(:name, :owner_id,owner_attributes: [
                                                            :email, :password, :password_confirmation
                                                      ] 
                                           )
    end
end
