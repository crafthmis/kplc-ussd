module Workspaces 
class TeamsController < ApplicationController
  layout "admin"
  before_action :set_organization, except: [:resend]

  before_action :find_team_ids, only: [:index, :show, :enter_workspace]
  before_action :set_teams ,only: [:index]

  before_action :set_team, only: [:show, :edit, :update, :destroy, :enter_workspace]

  # GET /teams
  # GET /teams.json
  def index
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @members = @team.users 
    @activities = PublicActivity::Activity.all
  end

  def enter_workspace 
      if @team_ids.include?(params[:id])
        flash[:notice] = "Welcome to your workspace"
        redirect_to team_path()
      else   
        flash.now[:danger] = "Access denied you do not have sufficient privileges"
        render :index 
      end   

  end

  # GET /teams/new
  def new
    @team = @organization.teams.build(owner_id: current_user.id)
    @team.team_interfaces.build 
  end

  # GET /teams/1/edit
  def edit
  end


  def resend
    member = User.find(params[:id])
    member.invite!
    flash[:notice] = "Invitation resend successfully"
    redirect_to organization_team_path(current_organization,member.team)
  end


  # POST /teams
  # POST /teams.json
  def create
    @team = @organization.teams.build(team_params)


     ##@team = Team.new(team_params)

    respond_to do |format|
      if @team.save

        if params["team"]["users_attributes"] != nil 
         save_and_invite(params["team"]["users_attributes"]) 
        end


         # deposition_source_id_is_empty = true
# params[:run][:layers_attributes].each do |layer_number, params|
#   if params[:deposition_source_id].present?
#     deposition_source_id_is_empty = false
#     break
#   end
# end
# if deposition_source_id_is_empty
#   # do the things you'd do here if the parameters pass validation
# end











        format.html { redirect_to organization_team_path(current_organization,@team), notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        #if params["team"]["users_attributes"] != nil 
        # save_and_invite(params["team"]["users_attributes"]) 
        #end
        format.html { redirect_to organization_team_path(current_organization,@team), notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to organization_teams_path(@organization), notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def save_and_invite(user_params)

             user_params.each do |layer_number, params|
             #user = User.find_or_initialize_by(email: params[:email])
             #user.define_singleton_method(:password_required?) { false }
             user = User.find_by(email: params[:email])

             if user == nil 
               user = User.invite!({ email: params[:email]}, current_user)
               membership = Membership.new(team: @team, user: user ,admin: params[:admin],team: current_team)
               current_organization.memberships << membership
               ##user.invite!(current_user)
             else
               #membership = Membership.new(team: @team, user: user ,admin: params[:admin],team: current_team)
               current_organization.memberships << membership
             end
             #User.invite!({:email => "new_user@example.com"}, current_user)
             
             #if user.save!
              # user.invite(current_user)
               #current_organization.memberships.create(team: @team,user: user,admin: params[:admin])
             #end

          end
    end

   def find_team_ids 
      @team_ids ||= current_user.return_workspace_ids 
    end

    def set_teams
      @teams ||= Team.find( @team_ids )
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    def set_organization 
      @organization = Organization.find(params[:organization_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name,:owner_id,:organization_id,:description,
                                     team_interfaces_attributes: [:id,:team_id, :organization_interface_id, :organization_id, :_destroy])
    end
end
end
