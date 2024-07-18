class PrepaidController < ApplicationController
   layout "admin"
  def index

  	  if params[:search] && params[:search][:date_created].present?
      start_date, end_date = params[:search][:date_created].split(' - ')
      start_date = Time.strptime(start_date,"%d %B %Y").in_time_zone
      end_date = Time.strptime(end_date,"%d %B %Y").in_time_zone


      diff = (end_date - start_date)/1.day
       
      @period = if diff <= 1
                  "hour"
                elsif diff <= 30
                   "day"
                else
                  "month"
                end

      @prepaid = Request.having_created_at_between(start_date, end_date).where("text ~* ?", '(^1|\*00\*1)')
      @buy_token =  @requests.where("text ~* ?", '(^1\*1|0\*1)')
      @latest_token =  @requests.where("text ~* ?", '(^1\*2|0\*2)')


    else
      @requests = Request.created_today.where("text ~* ?", '(^1|\*00\*1)')
      @request_chart = @requests
      @period = "hour"

      @prepaid = @requests.where("text ~* ?", '(^1|\*00\*1)')
      @buy_token = @requests.where("text ~* ?", '(^1\*1|^1.+\*0\*1|\*00\*1\*1)')
      @latest_token = @requests.where("text ~* ?", '(^1\*2|^1.+\*0\*2|\*00\*1\*2)')


    end
  

  end
end


# Request.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).requests.where("text ~* ?", '(^1\*2|^1.+\*0\*2|\*00\*1\*2)')
# @assigned_orders = Customer.joins(:rquests).where(requests: {"text ~* ?", '(^1\*2|^1.+\*0\*2|\*00\*1\*2)').distinct 
# @assigned_orders = Customer.joins(:requests).where(requests: {customer_id: req_id }).distinct 
# Request.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).where("text ~* ?", '(^1\*2|^1.+\*0\*2|\*00\*1\*2)')
# customer = Customer.joins(:requests).where(requests: {customer_id: Request.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).where("text ~* ?", '(^1\*2|^1.+\*0\*2|\*00\*1\*2)').pluck(:customer_id) }).pluck(:number)

  #  @prepaid = @requests.where("text ~* ?", '(^1|\*00\*1)')
# (^1\*1|^1\*.+\*0\*1|\*00\*1\*1|\*00\*1\*[^0{2}]+\*0\*1) Followed by 1 then *

# 1*1*00*1*2*0*1

# 1*2*0*1

# 2*1*00*1*2*0*1
    # @power_failure = Request.where("text ~* ?", '(^3|00\*3)')

    # @employee_staff = Request.where("text ~* ?", '^4\*1|00\*4\*1')
    # @employee_contractor = Request.where("text ~* ?", '^4\*2|00\*4\*2')

    # @prepaid_manage = Request.where("text ~* ?", '^5\*1|00\*5\*1')
    # @postpaid_mange = Request.where("text ~* ?", '^5\*1|00\*5\*2')


    # @my_bill = Request.where("text ~* ?", '(^2\*1|00\*2\*1)')
    # @pay_bill = Request.where("text ~* ?", '(^2\*2|00\*2\*2)')
    # @bill_alerts= Request.where("text ~* ?", '(^2\*3|00\*2\*3)')
    # @self_reading = Request.where("text ~* ?", '(^2\*4|00\*2\*4)')



