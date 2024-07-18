class EquitiesController < ApplicationController
  before_action :set_equity, only: [:show, :edit, :update, :destroy]

  # GET /equities
  # GET /equities.json
  def index
    @equities = Equity.all
  end

  # GET /equities/1
  # GET /equities/1.json
  def show
  end

  # GET /equities/new
  def new
    @equity = Equity.new
  end

  # GET /equities/1/edit
  def edit
  end

  # POST /equities
  # POST /equities.json
  def create
    @equity = Equity.new(equity_params)

    respond_to do |format|
      if @equity.save
        format.html { redirect_to @equity, notice: 'Equity was successfully created.' }
        format.json { render :show, status: :created, location: @equity }
      else
        format.html { render :new }
        format.json { render json: @equity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equities/1
  # PATCH/PUT /equities/1.json
  def update
    respond_to do |format|
      if @equity.update(equity_params)
        format.html { redirect_to @equity, notice: 'Equity was successfully updated.' }
        format.json { render :show, status: :ok, location: @equity }
      else
        format.html { render :edit }
        format.json { render json: @equity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equities/1
  # DELETE /equities/1.json
  def destroy
    @equity.destroy
    respond_to do |format|
      format.html { redirect_to equities_url, notice: 'Equity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equity
      @equity = Equity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def equity_params
      params.require(:equity).permit(:customer_id, :amount, :status, :equitable_id, :equitable_type)
    end
end
