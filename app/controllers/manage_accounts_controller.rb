class ManageAccountsController < ApplicationController
  
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
            
      # start_date = DateTime.strptime(start_date, '%d %B %Y')
      # end_date = DateTime.strptime(end_date, '%d %B %Y')
      

      #Time.zone.local(2012, 7, 11, 21)
      @requests = Request.having_created_at_between(start_date, end_date)

      @request_chart = @requests
      @customer_chart = Customer.having_created_at_between(start_date, end_date)


      @prepaid = @requests.where("text ~* ?", '(^1|00\*1)')
      @postpaid = @requests.where("text ~* ?", '(^2|00\*2)')
      @power_failure = @requests.where("text ~* ?", '(^3|00\*3)')
      @jua_for_sure = @requests.where("text ~* ?", '(^4|00\*4)')
      @manage_account = @requests.where("text ~* ?", '(^5|00\*5)')


    else
      @requests = Request.created_today
      @request_chart = @requests
      @customer_chart = Customer.created_one_week_ago
      @period = "hour"

      
      @prepaid = @requests.where("text ~* ?", '(^1|00\*1)')
      @postpaid = @requests.where("text ~* ?", '(^2|00\*2)')
      @power_failure = @requests.where("text ~* ?", '(^3|00\*3)')
      @jua_for_sure = @requests.where("text ~* ?", '(^4|00\*4)')
      @manage_account = @requests.where("text ~* ?", '(^5|00\*5)')

    end
  


  end
end
