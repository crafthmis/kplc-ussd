class BusinessIntelligence::ConnectivityController < BusinessIntelligenceController
  layout "admin"

  def index 
    @ytd_mtd_performance = Connectivity.ytd_mtd_performance
    @fy_target_cum_target_ytd_performance = Connectivity.fy_target_cum_target_ytd_performance
    @ytd_variance = Connectivity.ytd_variance 
    @mtd_variance = Connectivity.mtd_variance
    @connectivity_trend = Connectivity.connectivity_trend

    #@faulty_meters = FaultyMeter.faulty_meters
    @unvalidated_meters = UnvalidatedMeter.unvalidated_meters

    @faulty_transformer_weekly = FaultyTransformer.weekly_trend
    @weekly_trend_per_region = FaultyTransformer.weekly_trend_per_region
    @faulty_transformers = FaultyTransformer.faulty_transformers
    @weekly_transformer_failure = FaultyTransformer.weekly_transformer_failure 
  end
  def year_to_date_connectivity
  end

  def year_to_date_performance
  end

  def year_to_date_variance
  end

  def month_to_date_performace
  end

  def month_to_date_variance
  end

  def connectivity
  end

  def trend
  end
end
