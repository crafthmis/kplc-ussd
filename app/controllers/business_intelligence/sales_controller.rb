class BusinessIntelligence::SalesController < BusinessIntelligenceController
	layout "admin"
  before_action :set_tokens ,only: [:track_token]
  def index
  	@weekly_total = Sale.weekly_total_amount_units
  	@weekly_prepaid_unit_sale = PrepaidUnit.weekly_sale
  	@weekly_prepaid_cash_sale = PrepaidUnit.weekly_sale
  	@daily_energy_purchase = DailyPurchase.daily_energy_purchase

  	@postpaid_unit_target = PostpaidUnit.weekly_sale_vs_target
  	@postpaid_amount_target  = PostpaidAmount.weekly_sale_vs_target





        #@sales_cost = SalesSap.sales_vs_cost_trend
    
    @weekly_unit_sale = @weekly_total.pluck("pp")
    @weekly = [
                {
                  :label              => 'Sales',
                  :borderColor        => '#17a2b8',
                  :data               => @sales.pluck(" Sales")           },
                {
                  :label              => 'Energy purchase costs',
                  :borderColor        => '#28a745',
                  :data               => @sales.pluck("Energy purchase costs") 

                },
                 {
                  :label              => 'Other Costs',
                  :borderColor        => '#ffc107',
                  :data               => @sales.pluck("Other Costs") 
                },
                {
                  :label              => 'Profit',
                  :borderColor        => '#dc3545',
                  :data               => @sales.pluck("profit") 
               }
              ]
      ###---energy 
  @energy_labels = @energy_annual.pluck("source")
  @energy_data =  [ {
                        :backgroundColor => '#007bff',
                        :borderColor => '#007bff',
                        :data => @energy_annual.pluck("sales")
                   }]

  @new_connection_labels = @new_connection.pluck("pp")
  @new_connection_data =  [{
        type: 'line',
        data: @new_connection.pluck("new_connections"),
        backgroundColor: 'transparent',
        borderColor: '#007bff',
        pointBorderColor: '#007bff',
        pointBackgroundColor: '#007bff',
        fill: false
        ## pointHoverBackgroundColor: '#007bff',
        # pointHoverBorderColor    : '#007bff'
      }]


  @ims_labels = @ims_indices.pluck("period")
   @ims_data =  [
                  {
                    fill: false,
                    borderWidth: 2,
                    lineTension: 0,
                    spanGaps: true,
                    borderColor: '#efefef',
                    pointRadius: 3,
                    pointHoverRadius: 7,
                    pointColor: '#efefef',
                    pointBackgroundColor: '#efefef',
                    data: @ims_indices.pluck("value"),
                  }
                ]
    ################ PREPAID UNITS ###################

   @prepaid_unit_region = {}
  
   @prepaid_units.each do |prepaid_unit|
     view = Confirmation::VIEW[confirm.status.to_sym]
     if @prepaid_unit_region[prepaid_unit_region.region]
      @timeline[confirm.date_to_s.to_sym] << {status: confirm.status,create_date: confirm.create_date, mpesa: confirm.transid, meter: confirm.billrefnumber , message: confirm.messages,css: view[:styles], actions: view[:actions]}
     else
      @timeline[confirm.date_to_s.to_sym] = []
      @timeline[confirm.date_to_s.to_sym] << {status: confirm.status,create_date: confirm.create_date, mpesa: confirm.transid, meter: confirm.billrefnumber , message: confirm.messages,css: view[:styles], actions: view[:actions]}
     end
   end


  end

  def amount_units
  end


  private 

   def set_prepaid_units
    @prepaid_units ||= PrepaidUnit.all
   end


end
