class TeamsController < ApplicationController
  layout "admin"
  before_action :set_team, only: [:show, :edit, :update, :destroy]


  # GET /teams/1
  # GET /teams/1.json
  def show
    @members = @team.users 
    @activities = PublicActivity::Activity.all
  end


  # GET /teams/1/edit
  def edit
  end



  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
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
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name,:user_id, users_attributes: [:email, :_destroy])
    end
end
