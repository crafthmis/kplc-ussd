class CustomersController < ApplicationController
  layout "admin"
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  def analytics
    Request.where("text ~* ?", '\A1.')
  end

  def power_failure 
    @power_failure = Request.distinct.where("text ~* ?", '(^3|00\*3)').count('session_id')
  end

  def jua_for_sure 
    @kenya_power = Request.distinct.where("text ~* ?", '^4\*1|00\*4\*1').count('session_id')
    @contractor = Request.distinct.where("text ~* ?", '^4\*2|00\*4\*2').count('session_id')
  end

  def manage_account 
    @prepaid = Request.distinct.where("text ~* ?", '^5\*1|00\*5\*1').count('session_id')
    @postpaid = Request.distinct.where("text ~* ?", '^5\*1|00\*5\*2').count('session_id')
  end


  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :number)
    end
end
