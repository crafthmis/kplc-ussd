class UssdManager::IncidencesController < ApplicationController

  include UssdManager::IncidencesHelper
  layout "admin"
  before_action :set_incidence, only: [:show, :edit, :update, :destroy, :resolve]

  # GET /incidences
  # GET /incidences.json
  def index
    @incidences = Incidence.where(state: "open").order('created_at DESC').page params[:page]

    @markers = []
    @incidences.where.not(longitude: nil).where.not(latitude: nil).each do |f|
      marker_data = get_marker_data(f.full_address, f.customer.number)
      @markers << [marker_data, f.latitude, f.longitude]
    end

  end

  # GET /incidences/1
  # GET /incidences/1.json
  def show
  end

  # GET /incidences/new
  def new
    @incidence = Incidence.new
  end

  def resolve 
    @incidence.resolve!
    flash[:notice] = "Incidence has been resolved."
    redirect_to team_ussd_manager_incidences_path(current_team)
  end

  # GET /incidences/1/edit
  def edit
  end

  # POST /incidences
  # POST /incidences.json
  def create
    @incidence = Incidence.new(incidence_params)

    respond_to do |format|
      if @incidence.save
        format.html { redirect_to @incidence, notice: 'Incidence was successfully created.' }
        format.json { render :show, status: :created, location: @incidence }
      else
        format.html { render :new }
        format.json { render json: @incidence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidences/1
  # PATCH/PUT /incidences/1.json
  def update
    respond_to do |format|
      if @incidence.update(incidence_params)
        format.html { redirect_to @incidence, notice: 'Incidence was successfully updated.' }
        format.json { render :show, status: :ok, location: @incidence }
      else
        format.html { render :edit }
        format.json { render json: @incidence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidences/1
  # DELETE /incidences/1.json
  def destroy
    @incidence.destroy
    respond_to do |format|
      format.html { redirect_to incidences_url, notice: 'Incidence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incidence
      @incidence = Incidence.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def incidence_params
      params.require(:incidence).permit(:kind, :explanation, :customer_id)
    end
end
