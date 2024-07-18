class Money::PrepaidController < ApplicationAnalyticsController
   layout "admin"


  def safaricom
    @requests = Confirmation.created_today
    @tokens = Confirmation.group_by_hour #created_today.group_by { |token| token.create_date.strftime("%Y-%m-%d %H") }

    @chart_data = {}


    @tokens.each do |token|
       @chart_data[token["Hour"]] = token["Requests"] 
    end


  end

  def airtell
  end

  def safaricom_status
    # @tokens = Confirmation.created_today.group_by { |token| token.create_date.strftime('%H:%M') }
    # @chart_data = {}


    # tokens.each do |key,value|
    #    chart_data[key] = value.count
    # end
    render json: Confirmation.created_today.group(:status).count
  end

  def airtell_status
  end
end


