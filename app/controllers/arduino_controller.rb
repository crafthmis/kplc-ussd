class ArduinoController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  skip_around_action :set_time_zone

  before_action :set_membership


  def incoming
  	if @membership == nil && Rails.cache.read(params[:id].to_sym)
  	   code = 'NEW'
       MemWorker.perform_async(params[:id])
  	end

  	if @membership == nil && Rails.cache.read(params[:id].to_sym) == nil 
  	   code = 'DENIED'
  	end

	  if @membership 
	  	if @membership.remaining_days > 0
	  	   code = 'OK'
	  	   MembershipWorker.perform_async(@membership.id)
         ClearWorker.perform_in(5.seconds, "")
	  	elsif @membership.remaining_days <= 0 
	  		code = 'DENIED'
	  		MembershipWorker.perform_async(@membership.id)
        ClearWorker.perform_in(5.seconds, "")
	  	end
	 end

	Rails.cache.write(params[:id].to_sym, params[:id], expires_in: 5.seconds)



  	render json: {
      state: code,
    }.to_json
  end

 private


  def set_membership 
  	@membership = Membership.where(rfid: params[:id]).first
  end


end
