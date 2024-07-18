class BusinessIntelligence::SalesSapController < BusinessIntelligenceController
  layout "admin"
  def sales
    SalesSap.sales
    #render json:
  end

  def energy_purchase_cost
    SalesSap.energy_purchase_cost
  end

  def other_costs
    SalesSap.other_costs
  end

  def profit
    SalesSap.profit 
  end

  def sales_vs_cost_trend
    SalesSap.sales_vs_cost_trend
  end
end

