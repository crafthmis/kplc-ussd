class SmsChannelsController < ApplicationController
  before_action :set_sms_channel, only: [:show, :edit, :update, :destroy]

  # GET /sms_channels
  # GET /sms_channels.json
  def index
    @sms_channels = SmsChannel.all
  end

  # GET /sms_channels/1
  # GET /sms_channels/1.json
  def show
  end

  # GET /sms_channels/new
  def new
    @sms_channel = SmsChannel.new
  end

  # GET /sms_channels/1/edit
  def edit
  end

  # POST /sms_channels
  # POST /sms_channels.json
  def create
    @sms_channel = SmsChannel.new(sms_channel_params)

    respond_to do |format|
      if @sms_channel.save
        format.html { redirect_to @sms_channel, notice: 'Sms channel was successfully created.' }
        format.json { render :show, status: :created, location: @sms_channel }
      else
        format.html { render :new }
        format.json { render json: @sms_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms_channels/1
  # PATCH/PUT /sms_channels/1.json
  def update
    respond_to do |format|
      if @sms_channel.update(sms_channel_params)
        format.html { redirect_to @sms_channel, notice: 'Sms channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @sms_channel }
      else
        format.html { render :edit }
        format.json { render json: @sms_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_channels/1
  # DELETE /sms_channels/1.json
  def destroy
    @sms_channel.destroy
    respond_to do |format|
      format.html { redirect_to sms_channels_url, notice: 'Sms channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sms_channel
      @sms_channel = SmsChannel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sms_channel_params
      params.require(:sms_channel).permit(:type, :shortcode, :alphanumeric, :keyword, :organization_id)
    end
end
