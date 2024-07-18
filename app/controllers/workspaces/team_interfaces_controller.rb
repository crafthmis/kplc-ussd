module Workspaces 
class TeamInterfacesController < ApplicationController
  before_action :set_team_interface, only: [:show, :edit, :update, :destroy]

  # GET /team_interfaces
  # GET /team_interfaces.json
  def index
    @team_interfaces = TeamInterface.all
  end

  # GET /team_interfaces/1
  # GET /team_interfaces/1.json
  def show
  end

  # GET /team_interfaces/new
  def new
    @team_interface = TeamInterface.new
  end

  # GET /team_interfaces/1/edit
  def edit
  end

  # POST /team_interfaces
  # POST /team_interfaces.json
  def create
    @team_interface = TeamInterface.new(team_interface_params)

    respond_to do |format|
      if @team_interface.save
        format.html { redirect_to @team_interface, notice: 'Team interface was successfully created.' }
        format.json { render :show, status: :created, location: @team_interface }
      else
        format.html { render :new }
        format.json { render json: @team_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_interfaces/1
  # PATCH/PUT /team_interfaces/1.json
  def update
    respond_to do |format|
      if @team_interface.update(team_interface_params)
        format.html { redirect_to @team_interface, notice: 'Team interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_interface }
      else
        format.html { render :edit }
        format.json { render json: @team_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_interfaces/1
  # DELETE /team_interfaces/1.json
  def destroy
    @team_interface.destroy
    respond_to do |format|
      format.html { redirect_to team_interfaces_url, notice: 'Team interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_interface
      @team_interface = TeamInterface.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_interface_params
      params.require(:team_interface).permit(:team_id, :organization_interface_id, :organization_id)
    end
end
end
