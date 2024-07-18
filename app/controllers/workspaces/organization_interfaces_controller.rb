module Workspaces 
class OrganizationInterfacesController < ApplicationController
  before_action :set_organization_interface, only: [:show, :edit, :update, :destroy]

  # GET /organization_interfaces
  # GET /organization_interfaces.json
  def index
    @organization_interfaces = OrganizationInterface.all
  end

  # GET /organization_interfaces/1
  # GET /organization_interfaces/1.json
  def show
  end

  # GET /organization_interfaces/new
  def new
    @organization_interface = OrganizationInterface.new
  end

  # GET /organization_interfaces/1/edit
  def edit
  end

  # POST /organization_interfaces
  # POST /organization_interfaces.json
  def create
    @organization_interface = OrganizationInterface.new(organization_interface_params)

    respond_to do |format|
      if @organization_interface.save
        format.html { redirect_to @organization_interface, notice: 'Organization interface was successfully created.' }
        format.json { render :show, status: :created, location: @organization_interface }
      else
        format.html { render :new }
        format.json { render json: @organization_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organization_interfaces/1
  # PATCH/PUT /organization_interfaces/1.json
  def update
    respond_to do |format|
      if @organization_interface.update(organization_interface_params)
        format.html { redirect_to @organization_interface, notice: 'Organization interface was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization_interface }
      else
        format.html { render :edit }
        format.json { render json: @organization_interface.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organization_interfaces/1
  # DELETE /organization_interfaces/1.json
  def destroy
    @organization_interface.destroy
    respond_to do |format|
      format.html { redirect_to organization_interfaces_url, notice: 'Organization interface was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_interface
      @organization_interface = OrganizationInterface.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organization_interface_params
      params.require(:organization_interface).permit(:interface_id, :organization_id)
    end
end
end
