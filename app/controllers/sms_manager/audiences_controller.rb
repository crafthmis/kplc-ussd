class SmsManager::AudiencesController < SmsManagerController
  before_action :set_audience, only: [:show, :edit, :update, :destroy]

  # GET /sms_manager/audiences
  # GET /sms_manager/audiences.json
  def index
    @audiences = current_team.audiences.all
  end

  # GET /sms_manager/audiences/1
  # GET /sms_manager/audiences/1.json
  def show
  end

  # GET /sms_manager/audiences/new
  def new
    # @audience = current_team.audiences.where(organization_id: current_organization.id).new
    # @audience.contacts.build
    @audience = current_team.audiences.build(organization_id: current_organization.id,team_id: current_team.id)
    @audience.subscribers.build(organization_id: current_organization.id).build_contact
    #@audience = @current_organization.audiences.new
     #@audience.subscribers.build(team_id: current_team.id,organization_id: current_organization.id).build_contact
  end

  # GET /sms_manager/audiences/1/edit
  def edit
  end

  # POST /sms_manager/audiences
  # POST /sms_manager/audiences.json
  def create
    @audience = Audience.new(audience_params)
    respond_to do |format|
      if @audience.save!

        # params["audience"]["contacts_attributes"].each do |cont_params|
        #    @audience.subscribers << Contact.create(cont_params)
        # end

         #current_team.subscribers  current_team.id 

        format.html { redirect_to team_sms_manager_audiences_path(current_team), notice: 'Audience was successfully created.' }
        format.json { render :show, status: :created, location: [:sms_manager,@audience] }
      else
        format.html { render :new }
        format.json { render json: @audience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms_manager/audiences/1
  # PATCH/PUT /sms_manager/audiences/1.json
  def update
    respond_to do |format|
      if @audience.update!(audience_params)
        format.html { redirect_to team_sms_manager_audiences_path(current_team), notice: 'Audience was successfully updated.' }
        format.json { render :show, status: :ok, location: [:sms_manager,@audience] }
      else
        format.html { render :edit }
        format.json { render json: @audience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_manager/audiences/1
  # DELETE /sms_manager/audiences/1.json
  def destroy
    @audience.destroy
    respond_to do |format|
      format.html { redirect_to team_sms_manager_audiences_path(current_team), notice: 'Audience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_audience
      @audience = current_team.audiences.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def audience_params
      params.require(:audience).permit(:id,:name ,:organization_id,:team_id, 
                                        subscribers_attributes: [:id,:organization_id, :team_id,:audience_id, :contact_id, :_destroy ,
                                                                 contact_attributes: [:first_name,:last_name,:organization_id,:number, :_destroy ]])
    end
end
