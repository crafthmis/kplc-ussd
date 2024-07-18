class SmsManager::CampaignsController < SmsManagerController
  layout "admin"
  before_action :set_team ,only: [:index, :new, :create]
  before_action :set_team_from_resource ,except: [:index, :new, :create]
  before_action :set_sms_manager_campaign, only: [:show, :edit, :update, :destroy]
  before_action :set_type 

  # GET /sms_manager/campaigns
  # GET /sms_manager/campaigns.json
  def index
    @campaigns = type_class.all
  end

  # GET /sms_manager/campaigns/1
  # GET /sms_manager/campaigns/1.json
  def show
    @subscribers = current_organization.contacts.find(@campaign.broadcast_contacts)
  end

  # GET /sms_manager/campaigns/new
  def new
    @campaign = type_class.new
  end

  # GET /sms_manager/campaigns/1/edit
  def edit
  end

  # POST /sms_manager/campaigns
  # POST /sms_manager/campaigns.json
  def create
    @campaign = current_user.campaigns.build(sms_manager_campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to team_sms_manager_campaign_path(current_team,@campaign), notice: "#{type} was successfully created." }
        format.json { render :show, status: :created, location: [:sms_manager,@campaign] }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms_manager/campaigns/1
  # PATCH/PUT /sms_manager/campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(sms_manager_campaign_params)
        format.html { redirect_to team_sms_manager_campaign_path(current_team,@campaign), notice: "#{type} was successfully updated." }
        format.json { render :show, status: :ok, location: [:sms_manager,@campaign] }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_manager/campaigns/1
  # DELETE /sms_manager/campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to team_sms_manager_campaigns_path(current_team), notice: "#{type} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_team
      @team = current_organization.teams.find(params[:team_id])
    end


    def set_team_from_resource
      @team = current_team
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_sms_manager_campaign
      @campaign = current_organization.campaigns.find(params[:id])
    end

   def set_type
       @type = type
    end

    def type
        Campaign.types.include?(params[:type]) ? params[:type] : "Campaign"  #Campaign change to bulk 
    end

    def type_class 
        type.constantize 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sms_manager_campaign_params
      params.require(type.underscore.to_sym).permit(:name, :team_id, :organization_id,:type, :audience_id, :message)
    end
end
