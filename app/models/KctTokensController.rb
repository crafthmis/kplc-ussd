class KctTokensController < ApplicationController
    def show_sample
      @sample_record = KCT.fetch_sample_record
  
      # Render the view
      respond_to do |format|
        format.html # show_sample.html.erb
      end
    end
  end
  