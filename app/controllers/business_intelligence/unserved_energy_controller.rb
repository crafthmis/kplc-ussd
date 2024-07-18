class BusinessIntelligence::UnservedEnergyController < BusinessIntelligenceController
	layout "admin"

  def index 
    @weekly_unserved_energy = UnservedEnergy.weekly_unserved_energy
    @weekly_regional_trend = UnservedEnergy.weekly_regional_trend
    @unserved_energy_table = UnservedEnergy.unserved_energy_table
    @unserved_energy_chart = UnservedEnergy.unserved_energy_chart

  end
  
  def unserved_energy_table
  end

  def unserved_energy_chart
  end

  def weekly_unserved_energy
  end

  def weekly_regional_trend
  end
end
