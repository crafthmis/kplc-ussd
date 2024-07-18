class SmsManager::SmsTemplatesController < SmsManagerController
  before_action :set_team 
  before_action :set_sms_manager_sms_template, only: [:show, :edit, :update, :destroy]

  # GET /sms_manager/sms_templates
  # GET /sms_manager/sms_templates.json
  def index
    @templates = @team.sms_templates.all
  end

  # GET /sms_manager/sms_templates/1
  # GET /sms_manager/sms_templates/1.json
  def show
  end

  # GET /sms_manager/sms_templates/new
  def new
    @template = @team.sms_templates.new
  end

  # GET /sms_manager/sms_templates/1/edit
  def edit
  end

  # POST /sms_manager/sms_templates
  # POST /sms_manager/sms_templates.json
  def create
    @template = @team.sms_templates.new(sms_manager_sms_template_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to team_sms_manager_sms_templates_path(@team), notice: 'Sms template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms_manager/sms_templates/1
  # PATCH/PUT /sms_manager/sms_templates/1.json
  def update
    respond_to do |format|
      if @template.update(sms_manager_sms_template_params)
        format.html { redirect_to team_sms_manager_sms_templates_path(@template), notice: 'Sms template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_manager/sms_templates/1
  # DELETE /sms_manager/sms_templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to team_sms_manager_sms_templates_path(@team), notice: 'Sms template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_team 
      @team = current_organization.teams.find(params[:team_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_sms_manager_sms_template
      @template = SmsTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sms_manager_sms_template_params
      params.require(:sms_template).permit(:name, :organization_id,:team_id,:message)
    end
end
