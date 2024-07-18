class EnergyAnnual < Report
  self.table_name = "REPORTS.DW_ENERGY_SOURCE_ANNUAL"
  #self.primary_key = "trn_id"

  


  def self.energy_annual
	query = <<-SQL 
	   select source, round(sales,2) sales from REPORTS.DW_ENERGY_SOURCE_ANNUAL
   SQL
	result = Report.connection.exec_query(query)
  end


end 

