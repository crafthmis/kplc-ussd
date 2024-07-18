class BillingController < ApplicationController
  layout "admin"



  def index
  end

  def prepaid
    @buy_token = Request.distinct.where("text ~* ?", '(^1\*1|^1.+\*0\*1|00\*1\*1)').count('session_id')
    @latest_token = Request.distinct.where("text ~* ?", '(^1\*2|^1.+\*0\*2|\*00\*1\*2)').count('session_id')
  end
#(^1\*2|^1.+\*0\*2|00\*1\*2)

  def postpaid
    @my_bill = Request.distinct.where("text ~* ?", '(^2\*1|^2.+\*0\*1|00\*2\*1)').count('session_id')
    @pay_bill = Request.distinct.where("text ~* ?", '(^2\*2|^2.+\*0\*2|00\*2\*2)').count('session_id')
    @bill_alerts= Request.distinct.where("text ~* ?", '(^2\*3|^2.+\*0\*3|00\*2\*3)').count('session_id')
    @self_reading = Request.distinct.where("text ~* ?", '(^2\*4|^2.+\*0\*4|00\*2\*4)').count('session_id')
  end
  
end
