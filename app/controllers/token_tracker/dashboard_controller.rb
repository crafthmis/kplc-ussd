class TokenTracker::DashboardController < TokenTrackerController
 before_action :set_tokens ,only: [:track_token]
 #before_action :create_timeline ,only: [:track_token]

  layout "admin"
  def index
  end



def track_token

   @timeline = {}
  
   @confirmations.each do |confirm|
     view = Confirmation::VIEW[confirm.status.to_sym]
     if @timeline[confirm.date_to_s.to_sym]
      @timeline[confirm.date_to_s.to_sym] << {status: confirm.status,create_date: confirm.create_date, mpesa: confirm.transid, meter: confirm.billrefnumber , message: confirm.messages,css: view[:styles], actions: view[:actions]}
     else
      @timeline[confirm.date_to_s.to_sym] = []
      @timeline[confirm.date_to_s.to_sym] << {status: confirm.status,create_date: confirm.create_date, mpesa: confirm.transid, meter: confirm.billrefnumber , message: confirm.messages,css: view[:styles], actions: view[:actions]}
     end
   end

  respond_to do |format|

    format.html

    format.js

  end

end


  def revend_to_valid 
  end

  def escalate 
  end

  def revend 
  end



  private 

    def create_timeline 
      #  confirmations ||= @confirmations
      #  timeline = confirmations.distinct.pluck(:transtime)
      #  new_time = []

      # timeline.each do |key|
      #    new_time << {key => confirmations.where("date(transtime) = ?",key)}
      #  end

      # @let = new_time
    end

    def set_tokens 
      @confirmations ||= Confirmation.find_token(params[:track][:customer_details]).order('create_date DESC')
    end

    def set_params
      params.require(:track).permit(:customer_details)
    end


end
