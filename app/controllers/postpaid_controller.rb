class PostpaidController < ApplicationController
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
      #@customer_chart = Customer.having_created_at_between(start_date, end_date)


      @postpaid = @requests.where("text ~* ?", '(^2|00\*2)')
      @my_bill = @requests.where("text ~* ?", '(^2\*1|^2.+\*0\*1|00\*2\*1)')
      @pay_bill = @requests.where("text ~* ?", '(^2\*2|^2.+\*0\*2|00\*2\*2)')
      @bill_alerts= @requests.where("text ~* ?", '(^2\*3|^2.+\*0\*3|00\*2\*3)')
      @self_reading = @requests.where("text ~* ?", '(^2\*4|^2.+\*0\*4|00\*2\*4)')


    else
      @requests = Request.created_today.where("text ~* ?", '(^2|00\*2)')
      @request_chart = @requests
      @customer_chart = Customer.created_one_week_ago
      @period = "hour"

      @my_bill = @requests.where("text ~* ?", '(^2\*1|^2.+\*0\*1|00\*2\*1)')
      @pay_bill = @requests.where("text ~* ?", '(^2\*2|^2.+\*0\*2|00\*2\*2)')
      @bill_alerts= @requests.where("text ~* ?", '(^2\*3|^2.+\*0\*3|00\*2\*3)')
      @self_reading = @requests.where("text ~* ?", '(^2\*4|^2.+\*0\*4|00\*2\*4)')

    end
  


  end
end


