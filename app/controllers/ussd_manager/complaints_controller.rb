class UssdManager::ComplaintsController < ApplicationController
  layout "admin"
  before_action :set_complaint, only: [:show, :edit, :update, :destroy, :resolve]

  # GET /complaints
  # GET /complaints.json
  def index
    @complaints = Complaint.where(state: "open").order('created_at DESC').page params[:page]
  end

  # GET /complaints/1
  # GET /complaints/1.json
  def show
  end

  # GET /complaints/new
  def new
    @complaint = Complaint.new
  end

  # GET /complaints/1/edit
  def edit
  end


  def resolve 
    @complaint.resolve!
    flash[:notice] = "Complaint has been resolved."
    redirect_to team_ussd_manager_complaints_path(current_team)
  end


  def high_bill
    @complaints = Complaint.where(complaintable_type: "Accountment").page params[:page]
    render :index 
  end

  def faulty_meters
    @complaints = Complaint.where.not(complaintable_type: "Employee").page params[:page]
    render :index 
  end


  def report_employee 
    @complaints = Complaint.where(complaintable_type: "Employee").page params[:page]
    render :index 
  end


  # POST /complaints
  # POST /complaints.json
  def create
    @complaint = Complaint.new(complaint_params)

    respond_to do |format|
      if @complaint.save
        format.html { redirect_to @complaint, notice: 'Complaint was successfully created.' }
        format.json { render :show, status: :created, location: @complaint }
      else
        format.html { render :new }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /complaints/1
  # PATCH/PUT /complaints/1.json
  def update
    respond_to do |format|
      if @complaint.update(complaint_params)
        format.html { redirect_to @complaint, notice: 'Complaint was successfully updated.' }
        format.json { render :show, status: :ok, location: @complaint }
      else
        format.html { render :edit }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /complaints/1
  # DELETE /complaints/1.json
  def destroy
    @complaint.destroy
    respond_to do |format|
      format.html { redirect_to complaints_url, notice: 'Complaint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def complaint_params
      params.require(:complaint).permit(:customer, :info, :complaintable_id, :complaintable_type)
    end
end
