class ApplicationAnalytics::DashboardController < ApplicationAnalyticsController
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
	            
	      @requests = Request.having_created_at_between(start_date, end_date)

	      @request_chart = @requests
	      @customer_chart = Customer.having_created_at_between(start_date, end_date)


	      @prepaid = @requests.where("text ~* ?", '(^1|\*00\*1)')
	      @postpaid = @requests.where("text ~* ?", '(^2|\*00\*2)')
	      @power_failure = @requests.where("text ~* ?", '(^3|\*00\*3)')
	      @jua_for_sure = @requests.where("text ~* ?", '(^4|\*00\*4)')
	      @manage_account = @requests.where("text ~* ?", '(^6|\*00\*6)')


	    else
	      @requests = Request.created_today
	      @request_chart = @requests
	      @customer_chart = Customer.created_one_week_ago
	      @period = "hour"

	      
	      @prepaid = @requests.where("text ~* ?", '(^1|\*00\*1)')
	      @postpaid = @requests.where("text ~* ?", '(^2|\*00\*2)')
	      @power_failure = @requests.where("text ~* ?", '(^3|\*00\*3)')
	      @jua_for_sure = @requests.where("text ~* ?", '(^4|\*00\*4)')
	      @manage_account = @requests.where("text ~* ?", '(^6|\*00\*6)')

	    end

  end
end
