class BusinessIntelligence::DashboardController < BusinessIntelligenceController
  layout "bi"
  def index
  	@sales = SalesSap.sales.to_a

  	@energy_annual ||= EnergyAnnual.all
  	@new_connection  ||= NewConnection.new_connection
  	@ims_indices  ||= ImsIndices.caidi 

  	@total_sales = @sales.pluck(" Sales").inject(0){|sum,x| sum + x }
  	@total_energy_cost = @sales.pluck("Energy purchase costs").inject(0){|sum,x| sum + x }
  	@total_other_cost = @sales.pluck("Other Costs").inject(0){|sum,x| sum + x }
  	@total_profit = @sales.pluck("profit").inject(0){|sum,x| sum + x }


  	#@sales_cost = SalesSap.sales_vs_cost_trend
    
    @labels = @sales.pluck("pp")
  	@sales_data = [
                {
                  :label              => 'Sales',
                  :borderColor        => '#17a2b8',
                  :data               => @sales.pluck(" Sales")
                },
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


                
     


   end

##Columns \"pp\", \"period\", \" Sales\", \"Energy purchase costs\", \"Other Costs\", \"profit\", \"profit_margin\"
end
